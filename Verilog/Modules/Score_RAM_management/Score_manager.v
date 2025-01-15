module TopModule #(
    parameter N = 128,
    parameter BitAddr = $clog2(N),
    parameter addr_lenght = (((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_ins, en_init, en_read, we,
    input wire [BitAddr:0] i, j, addr_init,
    input wire [8:0] max, data_init,
    output wire [1:0] count_3,
    output wire [addr_lenght:0] addr_r,
    output wire [8:0] diag, left, up, score,
    output wire ready,
    output wire signal
);

    wire hit;
    wire [addr_lenght:0] addr_w;
    wire [8:0] data;
    wire en_din = en_ins | en_init;
    //wire [8:0] score;
  
    
    Counter_3 C_3 (.clk(clk), .rst(rst), .en(en_read), .signal(signal), .count(count_3));
    Reading_index_score #(.N(N)) R_i_s (.clk(clk), .rst(rst), .en_read(en_read), .count(count_3), .i(i), 
    .j(j), .addr(addr_r));
    Counter_1 C_1 (.clk(clk), .rst(rst), .en_init(en_init), .hit(hit));
    Writing_index_score #(.N(N)) W_i_s (.clk(clk), .rst(rst), .en_ins(en_ins), .en_init(en_init), .hit(hit), 
    .i(i), .j(j), .addr_init(addr_init), .max(max), .data_init(data_init), .addr_out(addr_w), .data_out(data));
    Scores_RAM #(.N(N)) S_RAM(.clk(clk), .rst(rst), .din(data), .en_din(en_din), .en_dout(en_read), .we(we), 
    .addr_din(addr_w), .addr_dout(addr_r), .dout(score));
    Output_manager #(.N(N)) O_m (.clk(clk), .rst(rst), .en_read(en_read), .count(count_3), .ram_data(score),
    .diag(diag), .left(left), .up(up), .ready(ready));
endmodule
