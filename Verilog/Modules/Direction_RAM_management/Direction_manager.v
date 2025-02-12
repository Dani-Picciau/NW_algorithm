`include "c:\..."

`include "Counter_1_dir.v"
`include "Writing_index_direction.v"
`include "Reading_index_direction.v"
`include "Direction_RAM.v"

module Direction_manager # (
    parameter N=128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst, 
    input wire we, en_init, en_ins, en_traceB,
    input wire [BitAddr:0] i_t, j_t, i, j, addr_init, 
    input wire [2:0] symbol_in, 
    output wire [2:0] symbol_out,
    
    //Internal wire
    output wire [addr_lenght:0] addr_r,
    output wire [addr_lenght:0] addr_w,
    output wire hit,
    output wire [2:0] symbol_w
);
    wire en_din = (en_ins | en_init);
    
    Direction_RAM #(
        .N(N)
    ) D_ram (
        .clk(clk),
        .rst(rst),
        .din(symbol_w),
        .en_din(en_din),
        .en_dout(en_traceB),
        .we(we),
        .addr_din(addr_w),
        .addr_dout(addr_r),
        .dout(symbol_out)
    );
    
    Reading_index_direction #(
        .N(N)
    ) R_i_d (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .i_t(i_t),
        .j_t(j_t),
        .addr_r(addr_r)
    );
    
    Writing_index_direction # (
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
        .symbol(symbol_in),
        .addr_out(addr_w),
        .symbol_out(symbol_w)
    );
    
    Counter_1_dir c1(
        .clk(clk),
        .rst(rst),
        .en_init(en_init),
        .hit(hit)
    );

    //end
endmodule