#include "nw.h"

#define MATCH_SCORE 1
#define MISMATCH_SCORE -1
#define GAP_SCORE -1

#define ALIGN '\\'
#define SKIPA '^'
#define SKIPB '<'

#define MAX(A,B) ( ((A)>(B))?(A):(B) )

/*NOTE IMPLEMENTATIVE: 
#define ALEN 128
#define BLEN 128

*/

void needwun(char SEQA[ALEN], char SEQB[BLEN],
             char alignedA[ALEN+BLEN], char alignedB[ALEN+BLEN],
             int M[(ALEN+1)*(BLEN+1)], char ptr[(ALEN+1)*(BLEN+1)]){
    //varabili utili per le celle.                
    int score, up_left, up, left, max;
    int row, row_up, r;
    int a_idx, b_idx;
    int a_str_idx, b_str_idx;

    //Inizializzo le prime righe orrizzontali e verticali della matrice, dove inserirò la sequenza del GAP_SCORE 
    init_row: for(a_idx=0; a_idx<(ALEN+1); a_idx++){
        M[a_idx] = a_idx * GAP_SCORE; //imposto nella prima riga orrizonatale i valori dati dalla somma del GAP_SCORE 
    }
    init_col: for(b_idx=0; b_idx<(BLEN+1); b_idx++){
        M[b_idx*(ALEN+1)] = b_idx * GAP_SCORE;//imposto nella prima riga verticale i valori dati dalla somma del GAP_SCORE
    }

    //Caricamento Matrice, tramite risoluzione del sotto problema
    fill_out: for(b_idx=1; b_idx<(BLEN+1); b_idx++){ 
        fill_in: for(a_idx=1; a_idx<(ALEN+1); a_idx++){
            if(SEQA[a_idx-1] == SEQB[b_idx-1]){ //verifica se le due basi azotate sono uguali 
                score = MATCH_SCORE; // se le  basi sono uguali imposto il valore MATCH_SCORE allo score
            } else {
                score = MISMATCH_SCORE; // in caso contrario imposta il valore MISMATCH_SCORE allo score
            }

            row_up = (b_idx-1)*(ALEN+1); //impostazione della riga in alto 
            row = (b_idx)*(ALEN+1); //impostazione della riga 
			
			
			//assegnazione valore della cella
            up_left = M[row_up + (a_idx-1)] + score; //score from digonal cell  
            up      = M[row_up + (a_idx  )] + GAP_SCORE;//score from upper cell
            left    = M[row    + (a_idx-1)] + GAP_SCORE;//score from side cell
			
			//trovo il massimo tra i tre score 
            max = MAX(up_left, MAX(up, left));
			
			//assegnazione del MAX_score nella cella 
            M[row + a_idx] = max;
            if(max == left){ // se risulta uguale alla cella di sinistra 
                ptr[row + a_idx] = SKIPB; //nella matrice char ptr inserisco nella cella SKIPB(che equivale ad una freccia che indica a sinistra)
            } else if(max == up){
                ptr[row + a_idx] = SKIPA; //nella matrice char ptr inserisco nella cella SKIPA(che equivale ad una freccia in alto)
            } else{
                ptr[row + a_idx] = ALIGN;//nella matrice char ptr inserisco nella cella ALIGN(che equivale ad una freccia che indica in diagonale)
            }
        }
    }

    // TraceBack (n.b. aligned sequences are backwards to avoid string appending) 
	//Inizializzo le variabili da utlizzare per la traccia
	a_idx = ALEN;
    b_idx = BLEN;
    a_str_idx = 0;
    b_str_idx = 0;

    trace: while(a_idx>0 || b_idx>0) { //fin quando non siamo nella cella [0,0]
        r = b_idx*(ALEN+1); //assegno alla variabile "r" un valore che equivale alla cella B corrente moltiplicata per 129 
	if (ptr[r + a_idx] == ALIGN){ //parto dall'ultima cella della mia matrice, verifico se il valore è uguale a "\\" 
            alignedA[a_str_idx++] = SEQA[a_idx-1]; //se fosse così vado in diagonale per la sequenza A e per la sequenza B
            alignedB[b_str_idx++] = SEQB[b_idx-1];
            a_idx--; // diminuisco gli indici e al prossimo ciclo avrò un ordine di grandezza in meno 
            b_idx--;
        }
        else if (ptr[r + a_idx] == SKIPB){ //controllo se nella cella ho una freccia a sinistra 
            alignedA[a_str_idx++] = SEQA[a_idx-1]; // se fosse così la sequenza A continua
            alignedB[b_str_idx++] = '-'; //mentre per la sequenza B indico un gap
            a_idx--;
        }
        else{ // SKIPA // al contrario da quanto visto sopra, proseguirà la sequenza B e nella sequenza A ho un gap 
            alignedA[a_str_idx++] = '-';
            alignedB[b_str_idx++] = SEQB[b_idx-1];
            b_idx--;
        }
    }

    // Pad the result, le restanti lettere  saranno impostate come valore  "_" 
    pad_a: for( ; a_str_idx<ALEN+BLEN; a_str_idx++ ) {
      alignedA[a_str_idx] = '_';
    }
    pad_b: for( ; b_str_idx<ALEN+BLEN; b_str_idx++ ) {
      alignedB[b_str_idx] = '_';
    }
}
