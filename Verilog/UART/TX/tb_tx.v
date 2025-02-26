`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2025 08:49:05
// Design Name: 
// Module Name: tx_tb
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


module tx_tb;
    parameter
    N=10,
    DATA_TO_FIFO=3,
    COUNT=66,
    DATA_SIZE = 8,
    ADDR_SIZE_EXP = 4,
    STOP_TICK = 16;
    
    reg clk, rst;
    reg [DATA_TO_FIFO-1:0] dataA, dataB;
    reg wrA, wrB;
    wire empty_A, empty_B, s_tick;
    wire [DATA_SIZE-1:0] dataA_in, dataAf, dataB_in, dataBf, dataout;
    wire txdone, read_A, read_B;
    wire tx, A_full, B_full;
    
    top_tx #(.N(N), .DATA_TO_FIFO(DATA_TO_FIFO), .COUNT(COUNT), .DATA_SIZE(DATA_SIZE), .ADDR_SIZE_EXP(ADDR_SIZE_EXP), .STOP_TICK(STOP_TICK))
        trasm (.clk(clk), .rst(rst), .s_tick(s_tick), .dataA(dataA), .dataB(dataB), .wrA(wrA), .wrB(wrB), .empty_A(empty_A), .empty_B(empty_B), .dataA_in(dataA_in), .dataAf(dataAf), 
        .dataB_in(dataB_in), .dataBf(dataBf), .dataout(dataout), .txdone(txdone), .read_A(read_A), .read_B(read_B), .tx(tx), .A_full(A_full), .B_full(B_full));
        
   always #0.5 clk = ~clk;
   
   initial 
   begin 
   clk=0;
   rst=1;
   wrA=0;
   wrB=0;
   dataA=3'b001; dataB=3'b110;
   
   #1.5 rst=0;
   #1 wrA=1; wrB=1;
   #1 dataA=3'b011; dataB=3'b100;
   //#1 dataA=3'b100; dataB=3'b011;
   //#1 dataA=3'b011; dataB=3'b111;
   #2 wrA=0; wrB=0;
   #1000 $stop;
   
   end
endmodule
