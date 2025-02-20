`include "/c:.../"

module Datapath #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire change_index, 
    input wire en_ins, en_init, en_read, en_traceB, we, 
    output wire signal,    
    output wire calculated,
    output wire end_init,
    output wire end_filling,
    output wire [2:0] symbol_out,
    output wire end_c,
    output wire [BitAddr:0] i_t_ram, j_t_ram,
    output wire signed [BitAddr:0] final_score,
    output wire [2:0] datoA, datoB,
    
    //Internal wires
    output wire [2:0] doutA, doutB, //SeqA_i_t, SeqB_j_t
    output wire [BitAddr:0] indexA, indexB,
    output wire [BitAddr:0] i_t, j_t,
    output wire [2:0] symbol, symbol_w,
    output wire signed [8:0] max,      
    output wire [1:0] count_3,
    output wire [addr_lenght:0] addr_r_sc, addr_w_sc,
    output wire [addr_lenght:0] addr_r_dir, addr_w_dir,
    output wire signed [8:0] diag, up, left, score,
    output wire [BitAddr:0] i, j,
    output wire [BitAddr:0] addr_init,
    output  wire signed [8:0] data_init, data,
    output wire hit,
    output wire value,
    output wire hit_4
);
    
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
        .count_3(count_3),
        .addr_r(addr_r_sc),
        .addr_w(addr_w_sc),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .signal(signal),
        .change_index(change_index),
        .hit(hit),
        .data(data)
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
        .symbol_out(symbol_out),
        .addr_r(addr_r_dir),
        .addr_w(addr_w_dir),
        .hit(hit),
        .symbol_w(symbol_w)
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
        .value(value),
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
        .indexA(indexA),
        .indexB(indexB)
    );
    
    //end
endmodule