`include "/c:..."

module Score_manager #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire we, 
    input wire en_ins, 
    input wire en_init,
    input wire en_read,
    input wire [BitAddr:0] addr, 
    input wire [8:0] data_in,
    input wire [8:0] max,
    input wire [BitAddr:0] i, j,
    input wire en_counter_3,

    output reg signal,
    output reg [8:0] diag, left, up
);
    wire [1:0] count_3;
    wire [addr_lenght:0] addr_r, addr_w;
    wire [8:0] data, score;
    wire hit, en_din;
    assign en_din = (en_init | en_ins);

    Scores_RAM #(.N(N)) S_RAM(.clk(clk), .rst(rst), .din(data), .en_din(en_din), .en_dout(en_read), .we(we), .addr_din(addr_w), .addr_dout(addr_r), .dout(score));
    Counter_3 C_3 (.clk(clk), .rst(rst), .en(en_counter_3), .signal(signal), .count(count_3));
    Counter_1 C_1 (.clk(clk), .rst(rst), .en_init(en_init), .hit(hit));
    Writing_index_score #(.N(N)) W_i_s (.clk(clk), .rst(rst), .en_ins(en_ins), .en_init(en_init), .hit(hit), .i(i), .j(j), .addr_init(addr), .max(max), .data_init(data_in), .addr_out(addr_w), .data_out(data));
    Reading_index_score #(.N(N)) R_i_s (.clk(clk), .rst(rst), .en_read(en_read), .count(count_3), .i(i), .j(j), .addr(addr_r));
    Output_manager #(.N(N)) O_m (.clk(clk), .rst(rst), .en_read(en_read), .count(count_3), .ram_data(score), .diag(diag), .left(left), .up(up));
endmodule