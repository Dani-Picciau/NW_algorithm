`include "C:\..."

module Datapath #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire [2:0] din_ram, // data in, to be written
    input wire en_ram, 
    input wire weA, weB, 
    input wire [BitAddr:0] addr_dinA, addr_dinB,
    input wire change_index, 
    input wire en_ins, en_init, en_read, en_traceB, we,     
    output wire calculated,
    output wire end_init,
    output wire end_filling,
    output wire end_c,
    output wire signed [BitAddr:0] final_score, 
    output wire [2:0] datoA, datoB,
    output wire hit_4,
    output wire [6:0] seg, 
    output wire [3:0] an 
);
    //Internal wires
    wire [2:0] doutA, doutB; //SeqA_i_t, SeqB_j_t
    wire [BitAddr:0] i_t, j_t;
    wire [2:0] symbol;
    wire signed [8:0] max;
    wire signed [8:0] diag, up, left;
    wire [BitAddr:0] i, j;
    wire [BitAddr:0] addr_init;
    wire signed [8:0] data_init;
    wire [BitAddr:0] i_t_ram, j_t_ram;
    wire [2:0] symbol_out;
    wire hit;
    wire signal;
    
    Score_manager # (
        .N(N)
    ) block1 (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init),
        .en_read(en_read),
        .we(we),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .max(max),
        .data_init(data_init),
        .diag(diag),
        .up(up),
        .left(left),
        .signal(signal),
        .change_index(change_index),
        .hit(hit)
    );
    
    Direction_manager # (
        .N(N)
    ) block2 (
        .clk(clk),
        .rst(rst),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_traceB(en_traceB),
        .i_t(i_t),
        .j_t(j_t),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .symbol_in(symbol),
        .symbol_out(symbol_out)
    );
    
    Signal_manager # (
        .N(N)
    ) block3 (
        .clk(clk),
        .rst(rst),
        .a(doutA),
        .b(doutB),
        .en_read(en_read),
        .en_init(en_init),
        .en_ins(en_ins),
        .change_index(change_index),
        .i(i),
        .j(j),
        .end_filling(end_filling),
        .data_init(data_init),
        .addr_init(addr_init),
        .end_init(end_init),
        .hit(hit),
        .diag(diag),
        .up(up),
        .left(left),
        .max(max),
        .symbol(symbol),
        .calculated(calculated),
        .hit_4(hit_4)
    );
    
    TraceBack_manager #(
        .N(N)
    ) block4 (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .symbol(symbol_out),
        .end_c(end_c),
        .i_t(i_t),
        .j_t(j_t),
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB),
        .SeqA_i_t(doutA),
        .SeqB_j_t(doutB)
    );
    
    AB_manager #(
        .N(N)
    ) block5 (
        .clk(clk),
        .rst(rst),
        .change_index(change_index),
        .en_traceB(en_traceB),
        .en_read(en_read),
        .i_t(i_t_ram),
        .j_t(j_t_ram),
        .i(i),
        .j(j),
        .doutA(doutA),
        .doutB(doutB),
        .din_ram(din_ram),
        .en_ram(en_ram),
        .weA(weA),
        .weB(weB),
        .addr_dinA(addr_dinA),
        .addr_dinB(addr_dinB)
    );
    
    Display_7_seg_manager #(
        .N(N)
    ) block6 (
        .clk(clk),
        .rst(rst),
        //.en_traceB(en_traceB),
        //.end_traceB(end_c),
        .submit_value(final_score),
        .seg(seg),
        .an(an)
    );
    
    //end
endmodule