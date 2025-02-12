`include "c:\..."

`include "Reading_direction_counter.v"

module TraceBack_manager#(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_traceB,
    input wire [2:0] symbol,
    output wire end_c,
    output wire [BitAddr:0] i_t, j_t,
    output wire [BitAddr:0] i_t_ram, j_t_ram
);
    Reading_direction_counter#(
        .N(N)
    ) R_d_c(
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .symbol(symbol),
        .end_c(end_c),
        .i_t(i_t),
        .j_t(j_t),
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram)
    );
endmodule