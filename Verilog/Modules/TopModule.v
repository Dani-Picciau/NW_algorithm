`include "/c:.../"

`include "FSM.v"
`include "Datapath.v"

//molule with every signal 

module TopModule #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire ready,
    
    //Input fsm
    output wire end_init,
    output wire calculated,
    output wire end_filling,
    output wire end_traceB,
    output wire hit_4,
    
    //Output fsm
    output wire we,
    output wire en_init,
    output wire en_ins,
    output wire en_read,
    output wire en_traceB,
    output wire change_index,
    output wire [2:0] state,
    
    // internal wires dp
    output wire [BitAddr:0] indexA, indexB,
    output wire [2:0] doutA, doutB,
    
    output wire value,
    output wire [BitAddr:0] i, j,
    output wire hit,
    output wire [BitAddr:0] addr_init,
    output wire signed [8:0] data_init, data,
    output wire signed [8:0] diag, up, left, score,
    output wire signed [8:0] max,
    output wire [2:0] symbol, symbol_w,
    output wire [1:0] count_3,
    output wire [addr_lenght-1:0] addr_r_sc, addr_w_sc,
    output wire [addr_lenght-1:0] addr_r_dir, addr_w_dir,
    output wire signal,
    
    
    output wire [BitAddr:0] i_t, j_t,
    output wire [2:0] symbol_out,
    output wire [BitAddr:0] i_t_ram, j_t_ram,
    
    output wire signed [BitAddr:0] final_score,
    output wire [2:0] datoA, datoB
    
);

    FSM fsm (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .end_init(end_init),
        .calculated(calculated),
        .end_filling(end_filling),
        .end_traceB(end_traceB),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .change_index(change_index),
        .state(state),
        .hit_4(hit_4)
    );
    
    Datapath #(
        .N(N)
    ) DP (
        .clk(clk),
        .rst(rst),
        .change_index(change_index),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .signal(signal),
        .calculated(calculated),
        .end_init(end_init),
        .end_filling(end_filling),
        .end_c(end_traceB),
        .symbol_out(symbol_out),
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram),
        .doutA(doutA),
        .doutB(doutB),
        .indexA(indexA),
        .indexB(indexB),
        .i_t(i_t),
        .j_t(j_t),
        .symbol(symbol),
        .symbol_w(symbol_w),
        .max(max),
        .count_3(count_3),
        .addr_r_sc(addr_r_sc),
        .addr_w_sc(addr_w_sc),
        .addr_r_dir(addr_r_dir),
        .addr_w_dir(addr_w_dir),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .data_init(data_init),
        .data(data),
        .hit(hit),
        .value(value),
        .hit_4(hit_4),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB)
    );
    
    //end
endmodule




// module without the internal wires:

/* module TopModule #(
    parameter N = 5,
    parameter BitAddr = $clog2(N+1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire ready,
    
    output wire signed [BitAddr:0] final_score,
    output wire [2:0] datoA, datoB
    
);
    //Input fsm
    wire end_init;
    wire calculated;
    wire end_filling;
    wire end_traceB;
    wire hit_4;
    
    //Output fsm
    wire we;
    wire en_init;
    wire en_ins;
    wire en_read;
    wire en_traceB;
    wire change_index;

    FSM fsm (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .end_init(end_init),
        .calculated(calculated),
        .end_filling(end_filling),
        .end_traceB(end_traceB),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .change_index(change_index),
        .hit_4(hit_4)
    );
    
    Datapath #(
        .N(N)
    ) DP (
        .clk(clk),
        .rst(rst),
        .change_index(change_index),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .calculated(calculated),
        .end_init(end_init),
        .end_filling(end_filling),
        .end_c(end_traceB),
        .hit_4(hit_4),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB)
    );
    
    //end
endmodule */