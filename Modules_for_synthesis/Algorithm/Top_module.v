`include "C:\..."

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
    input wire [2:0] din_ram, // data in, to be written
    input wire en_ram, 
    input wire weA, weB, 
    input wire [BitAddr:0] addr_dinA, addr_dinB,
    output wire signed [8:0] final_score, 
    output wire [2:0] datoA, datoB,
    output wire [6:0] seg, 
    output wire [3:0] an 
    
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
        .datoB(datoB),
        .seg(seg),
        .an(an),
        .din_ram(din_ram),
        .en_ram(en_ram),
        .weA(weA),
        .weB(weB),
        .addr_dinA(addr_dinA),
        .addr_dinB(addr_dinB)
    );
    
    //end
endmodule