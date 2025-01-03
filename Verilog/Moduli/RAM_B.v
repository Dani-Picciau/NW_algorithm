module RamA #(
    parameter N=128,
    parameter data = $clog2(N)  
) (
    input wire clk, rst, 
    input wire en_read, en_traceB,
    input wire [N-1:0]seqB,
    input wire [data:0] j, j_t,
    output reg [2:0] seqB_j, seqB_j_t
);
    reg [2:0] ram [N-1:0];

endmodule