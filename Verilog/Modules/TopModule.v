`include "/c:.../Score_manager.v"
`include "/c:.../Signal_manager.v"

module TopModule #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire [2:0] a, b,
    input wire change_index, 
    input wire en_ins, en_init, en_read, en_traceB, we, 
    output wire signal,    
    output wire calculated,
    output wire end_init,
    output wire end_filling,
    output wire [2:0] symbol_out,
    output wire end_c,
    output wire [BitAddr:0] i_t_ram, j_t_ram,
    
    //Internal wires
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
    output wire value
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
        .a(a),
        .b(b),
        .en_read(en_read),
        .en_init(en_init),
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
        .calculated(calculated)
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
        .j_t_ram(j_t_ram)
    );
    
    //end
endmodule