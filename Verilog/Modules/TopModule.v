`include "/c:.../Score_manager.v"
`include "/c:.../Signal_manager.v"

module TopModule #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1),
    //-----------------------
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire value,
    output wire [2:0] symbol,
    output wire calculated,
    input wire clk, rst,
    input wire en_ins, en_init, en_read, we,
    output wire signed [8:0] max, 
    input wire change_index,      
    output wire [1:0] count_3,
    output wire [addr_lenght:0] addr_r,
    output wire signed [8:0] diag, up, left, score,
    output wire signal,
    output wire [BitAddr:0] i, j,
    output wire end_filling,
    output wire [BitAddr:0] addr_init,
    output  wire signed [8:0]data_init,
    output wire end_init,
    output wire hit,
    
    output wire signed [8:0] diag_calc, up_calc, lx_calc
);
    
    Score_manager # (
        .N(N)
    ) block1 (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init),
        .en_read(en_read),
        .we(we),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .max(max),
        .data_init(data_init),
        .count_3(count_3),
        .addr_r(addr_r),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .signal(signal),
        .change_index(change_index),
        .hit(hit)
    );
    
    Signal_manager # (
        .N(N)
    ) block2 (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .en_init(en_init),
        .change_index(change_index),
        .i(i),
        .j(j),
        .end_filling(end_filling),
        .data_init(data_init),
        .addr_init(addr_init),
        .end_init(end_init),
        .hit(hit),
        
        .value(value),
        .diag(diag),
        .up(up),
        .left(left),
        .max(max),
        .symbol(symbol),
        .calculated(calculated),
        
        .diag_calc(diag_calc),
        .up_calc(up_calc),
        .lx_calc(lx_calc)
    );
    
    //end
endmodule