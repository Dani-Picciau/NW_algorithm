`include "/c:.../"

`include "FSM.v"
`include "Datapath.v"

module TopModule #(
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
endmodule