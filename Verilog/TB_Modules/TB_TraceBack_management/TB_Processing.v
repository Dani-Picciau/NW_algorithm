`include "/c:.../Processing.v"

module Processing_TB;
    reg clk, rst, en_traceB;
    reg [2:0] SeqA_i_t, SeqB_j_t;
    reg [2:0] symbol;
    wire signed [8:0] final_score;
    wire [2:0] datoA, datoB;

    // Istanziamo il modulo Processing
    Processing proc (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .SeqA_i_t(SeqA_i_t),
        .SeqB_j_t(SeqB_j_t),
        .symbol(symbol),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB)
    );

    // Generazione del clock (50 MHz → periodo 20 ns)
    always #0.5 clk = ~clk;

    initial begin
        // Inizializzazione segnali
        clk = 0;
        rst = 1;
        en_traceB = 0;
        SeqA_i_t = 3'b000;
        SeqB_j_t = 3'b000;
        symbol = 3'b000;
        
        // RESET
        #5.5 rst = 0;
        #5  en_traceB = 1;
             
        // Test sequenze "CACTG" e "GATGC"
        #10 SeqA_i_t = 3'b001; SeqB_j_t = 3'b110; symbol = 3'b100; // G vs C 
        #10 SeqA_i_t = 3'b001; SeqB_j_t = 3'b001; symbol = 3'b001; // G vs G 
        #10 SeqA_i_t = 3'b011; SeqB_j_t = 3'b011; symbol = 3'b001; // T vs T 
        #10 SeqA_i_t = 3'b110; SeqB_j_t = 3'b100; symbol = 3'b010; // C vs A 
        #10 SeqA_i_t = 3'b100; SeqB_j_t = 3'b100; symbol = 3'b001; // A vs A 
        #10 SeqA_i_t = 3'b110; SeqB_j_t = 3'b001; symbol = 3'b001; // C vs G 
        
        #10 en_traceB=0;
        #10 $stop;
    end
    
    //end
endmodule
