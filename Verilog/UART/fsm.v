`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it 
// Description: fsm di trasmissione
//////////////////////////////////////////////////////////////////////////////////


module fsm_t  
#(
	parameter DATA_BW=8,
    parameter DATA_BW_BIT=4
)(
	input wire clk,rst,                     //segnali di controllo globali
	input wire transmit,                    /*transmit=1 --> richiesta di trasmissione da parte del produttore*/
	input wire data_hit,                    /*data_hit=1 --> segnalazione della trasmissione dell'ultimo bit di informazione*/
	input wire [DATA_BW-1:0] data_in,       //dato da trasmettere
	input wire [DATA_BW_BIT-1:0] count,     //contatore dati da trasmettere
	output reg en,                          /*en=1 --> abilitazione trasmissione del dato e conteggio dati da trasmettere*/ 
	output reg busy,                        //busy=1 --> trasmissione frame su TX
	output reg TX                           /*TX è il segnale in uscita dalla UART contenente il frame di trasmissione {start,dato,stop}*/
);

	parameter IDLE=3'b000, START=3'b001 , DATA=3'b010, STOP_1=3'b011, STOP_2=3'b100;
		
	reg [2:0] state, state_nxt; 

	//logica sequenziale: registro di stato    
	always @(posedge clk, posedge rst)
		if(rst==1'b1) state<=IDLE;
		else state<=state_nxt;

	//logica combinatoria: determinazione dello stato futuro
	always @(transmit, state, data_hit)
		case(state) 
			IDLE: /*l'arrivo della richiesta di trasmissione porta il sistema nello stato di trasmissione dello start bit*/
				begin 
					if(transmit==1'b1) state_nxt=START; 
					else state_nxt=IDLE;
				end
			START: /*dopo lo start bit il sistema si deve portare nello stato di trasmissione di tutto il pacchetto di informazione*/
				state_nxt=DATA; 
			DATA: /*quando viene spedito l'ultimo dato del pacchetto il sistema si deve portare nello stato di trasmissione del/dei bit di stop*/ 
				begin
					if(data_hit==1'b1) state_nxt=STOP_1; 
					else state_nxt=DATA;
				end 
			STOP_1: //trasmissione del primo stop bit
				state_nxt=STOP_2;  
			STOP_2:  //trasmissione del primo stop bit  
				state_nxt=IDLE;   
			default: state_nxt=IDLE;
		endcase

	//logica combinatoria: determinazione delle uscite
	always @(state,data_in,count)
		case(state) 
			IDLE: 
				begin 
					TX=1'b1;            //in IDLE la linea TX è attiva alta
					en=1'b0;            /*in IDLE il contatore dei dati trasmessi è disabilitato*/
					busy=1'b0;          /*in IDLE la UART è disponibile ad accettare nuove transazioni*/
				end
			START: 
				begin 
					TX=1'b0;            //in START viene trasmesso lo start bit {0}
					en=1'b0;            /*in START il contatore dei dati trasmessi è ancora disabilitato*/
					busy=1'b1;          /*in START la UART non è disponibile ad accettare nuove transazioni*/
				end
			DATA:
				begin 
					TX=data_in[count];  /*in DATA viene trasmessa l'informazione registrata nel registro di input*/
					en=1'b1;            /*in DATA il contatore dei dati trasmessi viene abilitato*/
					busy=1'b1;          /*in DATA la UART non è disponibile ad accettare nuove transazioni*/
				end
			STOP_1:
				begin 
					TX=1'b1;            //in STOP_1 viene trasmesso il primo stop bit {0}
					en=1'b0;            /*in STOP_1 il contatore dei dati trasmessi è disabilitato*/
					busy=1'b1;          /*in STOP_1 la UART non è disponibile ad accettare nuove transazioni*/
				end
			STOP_2:
				begin 
					TX=1'b1;            //in STOP_2 viene trasmesso il primo stop bit {0}
					en=1'b0;            /*in STOP_2 il contatore dei dati trasmessi è disabilitato*/
					busy=1'b1;          /*in STOP_2 la UART non è disponibile ad accettare nuove transazioni*/
				end
			default:
				begin 
					TX=1'b1;
					en=1'b0;
					busy=1'b0;
				end
		endcase

endmodule