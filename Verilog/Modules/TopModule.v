`include "/c:.../Score_manager.v"

module TopModule #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_ins, en_init, en_read, we,
    input wire [BitAddr:0] addr_init,
    input wire [8:0] max, data_init,
    input wire change_index,      
    output wire [1:0] count_3,
    output wire [addr_lenght:0] addr_r,
    output wire [8:0] diag, up, left, score,
    output wire signal,
    output wire [BitAddr:0] i, j,
    output wire end_filling
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
        .change_index(change_index)
    );
    
    Signal_manager # (
        .N(N)
    ) block2 (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .change_index(change_index),
        .i(i),
        .j(j),
        .end_filling(end_filling)
    );
    
    //end
endmodule