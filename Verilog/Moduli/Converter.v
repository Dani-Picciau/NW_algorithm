module Converter (
    input clk, rst,                
    input start,                  // Segnale di inizio per iniziare la conversione
    output reg [2:0] rom_data,    // Dati letti dalla ROM
    output reg done               // Flag che indica se la conversione è terminata
);
    reg [2:0] memory [0:127];      // Array di 128 posizioni con valori a 3 bit
    reg [6:0] index, index_next;   // Indice per scorrere l'array (fino a 128)
    reg [7:0] char;                // Carattere letto dal file
    integer file;                  // Descrittore del file
    
    // Apre il file al momento dell'inizializzazione
    initial begin
        index = 0;                   // Inizializza l'indice
        index_next=0;
        done = 0;                   // Flag di completamento
        file = $fopen("C:/Esercizi verilog laboratorio/TestBlocks/TestBlocks/file.txt", "r"); // Apre il file di testo
        if (file == 0) begin
            $display("Errore: impossibile aprire il file.");
            $finish;
        end
    end

    // Lettura sequenziale senza cicli
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            index <= 0;                // Resetta l'indice
            done <= 0;               // Resetta il flag di completamento
        end 
        else if (start && !done) begin
            char = $fgetc(file);     // Legge un carattere dal file
            case (char)
                "G": memory[index] = 3'b001; // G -> 1
                "T": memory[index] = 3'b010; // T -> 2
                "A": memory[index] = 3'b011; // A -> 3
                "C": memory[index] = 3'b100; // C -> 4
                default: memory[index] = 3'bxxx; // Carattere non valido
            endcase
            index_next <= index + 1; 

            // Controlla se il file è stato letto completamente
            if ($feof(file) || index == 128) begin
                $fclose(file);           // Chiude il file quando completato
                done <= 1;               // Imposta done quando la lettura è finita
            end
        end
    end

    // Invia i dati alla ROM durante la lettura
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rom_data <= 3'b000; // Resetta rom_data
        end else if (!done) rom_data <= memory[index]; 
        else rom_data <= 3'b000;
    end
endmodule