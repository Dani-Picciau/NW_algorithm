`include "c:\..."

`include "Initialization_counter.v"
`include "Insertion_counter.v" 
`include "Match_mismatch.v"
`include "Max.v"

module Signal_manager #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
)(
    input wire [2:0] a, b,
    input wire signed [8:0] diag, up, left,
    input wire clk, rst,
    input wire en_read,
    input wire en_init,
    input wire change_index, 
    input wire hit, 
    output wire signed [8:0] max,
    output wire [2:0] symbol, 
    output wire calculated,
    output wire end_filling,
    output wire [BitAddr:0] i, j,
    output wire signed [8:0] data_init,
    output wire [BitAddr:0] addr_init,
    output wire end_init,
    
    //Internal wires
    output wire value
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
    
    Initialization_counter #(
        .N(N)
    ) block2 (
        .clk(clk),  
        .rst(rst),
        .en_init(en_init),
        .addr(addr_init),
        .data(data_init),
        .end_init(end_init),
        .hit(hit)
    );
     
    Max # ( 
        .gap_score(gap_score),
        .match_score(match_score),
        .mismatch_score(mismatch_score)
    ) block3 (
        .clk(clk),
        .rst(rst),
        .value(value),
        .diag(diag),
        .up(up),
        .lx(left),
        .max(max),
        .symbol(symbol),
        .calculated(calculated)
    );
    
    Match_mismatch Mm(
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .en_read(en_read),
        .value(value)
    );
endmodule