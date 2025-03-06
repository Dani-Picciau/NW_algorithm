`include "c:\..."
 
`include "Counter_1_sc.v"
`include "Counter_3.v"
`include "Reading_index_score.v"
`include "Writing_index_score.v"
`include "Scores_RAM.v"
`include "Output_manager.v"

//Module with every internal wire in output
`timescale 1ns / 1ps

module Score_manager #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1)))
) (
    input wire clk, rst,
    input wire en_ins, en_init, en_read, we,
    input wire  change_index,
    input wire signed [8:0] max, 
    input wire signed [8:0]data_init,
    input wire [BitAddr:0] i, j, addr_init,
    output wire signed[8:0] diag, up, left,
    output wire signal,
    output wire hit, //It's also an internal wire
    
    //Internal wires
    output wire [1:0] count_3,
    output wire [addr_lenght-1:0] addr_r, addr_w,
    output wire signed [8:0] score, data
);
    wire en_din = en_ins | en_init;
  
    Counter_3 C_3 (
        .clk(clk), 
        .rst(rst), 
        .en(en_read), 
        .signal(signal), 
        .count(count_3)
    );
    
    Reading_index_score # (
        .N(N)
    ) R_i_s (
        .clk(clk), 
        .rst(rst), 
        .en_read(en_read),
        .count(count_3), 
        .i(i), 
        .j(j), 
        .addr(addr_r), 
        .change_index(change_index)
    );
    
    Counter_1_sc C_1 (
        .clk(clk), 
        .rst(rst), 
        .en_init(en_init), 
        .hit(hit)
    );
    
    Writing_index_score # (
        .N(N)
    ) W_i_s (
        .clk(clk), 
        .rst(rst), 
        .en_ins(en_ins), 
        .en_init(en_init), 
        .hit(hit), 
        .i(i), 
        .j(j), 
        .addr_init(addr_init), 
        .max(max), 
        .data_init(data_init), 
        .addr_out(addr_w), 
        .data_out(data)
    );
    
    Scores_RAM # (
        .N(N)
    ) S_RAM (
        .clk(clk), 
        .rst(rst), 
        .din(data), 
        .en_din(en_din), 
        .en_dout(en_read), 
        .we(we), 
        .addr_din(addr_w), 
        .addr_dout(addr_r), 
        .dout(score)
    );
    
    Output_manager O_m (
        .clk(clk), 
        .rst(rst), 
        .en_read(en_read), 
        .count(count_3), 
        .ram_data(score),
        .diag(diag), 
        .left(left), 
        .up(up), 
        .signal(signal)
    );
    
    //end
endmodule


//module without internal wires in output

/* module Score_manager #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1)))
) (
    input wire clk, rst,
    input wire en_ins, en_init, en_read, we,
    input wire change_index,
    input wire signed [8:0] max, 
    input wire signed [8:0]data_init,
    input wire [BitAddr:0] i, j, addr_init,
    output wire signed[8:0] diag, up, left,
    output wire signal,
    output wire hit //It's also an internal wire
    
   
);
     //Internal wires
    wire [1:0] count_3;
    wire [addr_lenght-1:0] addr_r, addr_w;
    wire signed [8:0] score, data;
    wire en_din = en_ins | en_init;
  
    Counter_3 C_3 (
        .clk(clk), 
        .rst(rst), 
        .en(en_read), 
        .signal(signal), 
        .count(count_3)
    );
    
    Reading_index_score # (
        .N(N)
    ) R_i_s (
        .clk(clk), 
        .rst(rst), 
        .en_read(en_read),
        .count(count_3), 
        .i(i), 
        .j(j), 
        .addr(addr_r), 
        .change_index(change_index)
    );
    
    Counter_1_sc C_1 (
        .clk(clk), 
        .rst(rst), 
        .en_init(en_init), 
        .hit(hit)
    );
    
    Writing_index_score # (
        .N(N)
    ) W_i_s (
        .clk(clk), 
        .rst(rst), 
        .en_ins(en_ins), 
        .en_init(en_init), 
        .hit(hit), 
        .i(i), 
        .j(j), 
        .addr_init(addr_init), 
        .max(max), 
        .data_init(data_init), 
        .addr_out(addr_w), 
        .data_out(data)
    );
    
    Scores_RAM # (
        .N(N)
    ) S_RAM (
        .clk(clk), 
        .rst(rst), 
        .din(data), 
        .en_din(en_din), 
        .en_dout(en_read), 
        .we(we), 
        .addr_din(addr_w), 
        .addr_dout(addr_r), 
        .dout(score)
    );
    
    Output_manager O_m (
        .clk(clk), 
        .rst(rst), 
        .en_read(en_read), 
        .count(count_3), 
        .ram_data(score),
        .diag(diag), 
        .left(left), 
        .up(up), 
        .signal(signal)
    );
    
    //end
endmodule */