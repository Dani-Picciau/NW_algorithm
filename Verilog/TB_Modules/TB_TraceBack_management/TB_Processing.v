`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2025 11:22:06
// Design Name: 
// Module Name: TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TB;


   // Parametri
    parameter N = 128;
    parameter score_length = $clog2(N+1);
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    parameter dash = 3'b111;

    // Segnali di input
    reg clk, rst;
    reg en_traceB;
    reg [2:0] SeqA_i_t;
    reg [2:0] SeqB_j_t;
    reg [2:0] symbol;
    wire signed [score_length:0] final_score;
    wire [2:0] datoA;
    wire [2:0] datoB;
    
    
    Processing #(
     N 
    ) proc (
    
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
    
    always #0.5 clk=~clk; 
    
    initial begin
    
    clk=0; rst=1;  en_traceB=0; SeqA_i_t=0; SeqB_j_t=0; symbol=0;
    
    #3.5 rst=0;
         en_traceB=1;
         symbol=100;
         SeqA_i_t= 3'b100; 
         SeqB_j_t=3'b100;
         
    #5   symbol=010;
         SeqA_i_t= 3'b100; 
         SeqB_j_t=3'b110;
         
    #5   symbol=001;
         SeqA_i_t= 3'b100; 
         SeqB_j_t=3'b110;
    

    
    
    
    
        // Fine del test
        #20;
        $stop;
    end

endmodule
