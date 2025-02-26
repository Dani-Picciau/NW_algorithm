`include "C:\Users\crist\Desktop\GitHUb\Progetto ESD\NW_algorithm\Verilog\UART"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: top trasmissione
//////////////////////////////////////////////////////////////////////////////////


module top_tx #(
    parameter
    N=14,
    DATA_TO_FIFO=3,
    DATA_SIZE = 8,
    ADDR_SIZE_EXP = 4,
    STOP_TICK = 16,
    BAUD_CNT=10416
    )(
    input wire clk, rst,
    //output wire s_tick, //controllo del baud rate
    input wire [DATA_TO_FIFO-1:0] dataA, dataB,
    input wire wrA, wrB, 
    //output wire empty_A, empty_B, //empty di controllo
    //output wire [DATA_SIZE-1:0] dataA_in, dataAf, dataB_in, dataBf, dataout, //dati di controllo
    //output wire txdone, read_A, read_B, //txdone di controllo
    output wire tx, A_full, B_full
);
    wire [DATA_SIZE-1:0] data_A_tot, data_B_tot, data_A_out, data_B_out, data_out;
    wire A_full, B_full, hit, tick;
    wire emptyA, emptyB, not_emptyA, not_emptyB, not_empty;
    wire readA, readB;
    wire tx_done;
    
    //segnali per il testbench
//    assign s_tick=tick;
//    assign read_A=readA;
//    assign read_B=readB;
//    assign txdone=tx_done;
//    assign dataout=data_out;
//    assign empty_A=emptyA;
//    assign empty_B=emptyB;
//    assign dataA_in=data_A_tot;
//    assign dataAf=data_A_out;
//    assign dataB_in=data_B_tot;
//    assign dataBf=data_B_out;
    



    baud_rate_clk_gen #(.BAUD_CNT(BAUD_CNT), .BAUD_BIT(N)) br_g (.clk(clk), .rst(rst), .baud_clk(tick));

    cod_out #(.N(DATA_SIZE), .DATA_TO_FIFO(DATA_TO_FIFO)) codA (.clk(clk), .rst(rst), .char(dataA), .Txdata_in(data_A_tot));
    cod_out #(.N(DATA_SIZE), .DATA_TO_FIFO(DATA_TO_FIFO)) codB (.clk(clk), .rst(rst), .char(dataB), .Txdata_in(data_B_tot));


    fifo #(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE_EXP(ADDR_SIZE_EXP)) fifoA (.clk(clk), .rst(rst), .rd_from_fifo(readA), .wr_to_fifo(wrA),
        .wr_data_in(data_A_tot), .rd_data_out(data_A_out), .empty(emptyA), .full(A_full));

    fifo #(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE_EXP(ADDR_SIZE_EXP)) fifoB (.clk(clk), .rst(rst), .rd_from_fifo(readB), .wr_to_fifo(wrB),
        .wr_data_in(data_B_tot), .rd_data_out(data_B_out), .empty(emptyB), .full(B_full));

    assign not_emptyA=~emptyA;
    assign not_emptyB=~emptyB;

    selector_fifo #(.DATA_BITS(DATA_SIZE)) sel (.clk(clk), .rst(rst), .tx_done(tx_done), .data_A(data_A_out), .data_B(data_B_out), .not_emptyA(not_emptyA), 
        .not_emptyB(not_emptyB), .hit(emptyA), .data(data_out), .not_empty(not_empty), .readA(readA), .readB(readB));

    uart_transmitter #(.DATA_BITS(DATA_SIZE), .STOP_TICK(STOP_TICK)) tx_out (.clk(clk), .rst(rst), .tx_start(not_empty),
        .sample_tick(tick), .data_in(data_out), .tx_done(tx_done), .tx_data(tx));
    
    
endmodule