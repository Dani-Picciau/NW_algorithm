`include "c:\..."

`include "Reading_direction_counter.v"
`include "Processing.v"

module TraceBack_manager #(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_traceB,
    input wire [2:0] symbol,
    input wire [2:0] SeqA_i_t, SeqB_j_t,
    output wire end_c,
    output wire [BitAddr:0] i_t, j_t,
    output wire [BitAddr:0] i_t_ram, j_t_ram,
    output wire signed [8:0] final_score,
    output wire [2:0] datoA, datoB
);
    Reading_direction_counter#(
        .N(N)
    ) R_d_c(
        .clk(clk),
        .rst(rst),
        .symbol(symbol),
        .end_c(end_c),
        .i_t(i_t),
        .j_t(j_t),
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram)
    );
    
    Processing #(
        .N(N)
    ) processing (
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
    
    //end
endmodule