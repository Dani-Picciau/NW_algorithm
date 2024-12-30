module RamA #(
    parameter N=128,
    parameter data = $clog2(N)  
) (
    input wire clk, rst, 
    input wire en_read, en_traceB,
    input wire [N-1:0]seqA,
    input wire [data:0] i, i_t,
    output reg [2:0] seqA_i, seqA_i_t
);
    reg [2:0] ram [N-1:0];

endmodule