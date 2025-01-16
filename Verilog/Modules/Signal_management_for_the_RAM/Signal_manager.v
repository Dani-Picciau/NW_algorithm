`include "Initialization_counter.v"
`include "Insertion_Counter.v" 
`include "Match_mismatch.v"
`include "Max.v"

module Signal_manager #(
    parameter N = 128
)(
    input wire clk, rst,
    input wire en_read,
    input wire change_index,      
    output wire end_filling,
    output wire [($clog2(N)):0] i, j
);

    Insertion_counter #(
        .N(N)
    ) I_c (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .change_index(change_index),
        .end_filling(end_filling),
        .i(i),
        .j(j)
    );

endmodule