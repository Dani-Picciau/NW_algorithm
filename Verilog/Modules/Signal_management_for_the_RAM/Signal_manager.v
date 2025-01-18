`include "Initialization_counter.v"
`include "Insertion_counter.v" 
`include "Match_mismatch.v"
`include "Max.v"

module Signal_manager #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1)
)(
    input wire clk, rst,
    input wire en_read,
    input wire change_index,      
    output wire end_filling,
    output wire [BitAddr:0] i, j
);

    Insertion_counter #(
        .N(N)
    ) block1 (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .change_index(change_index),
        .end_filling(end_filling),
        .i(i),
        .j(j)
    );
    
endmodule