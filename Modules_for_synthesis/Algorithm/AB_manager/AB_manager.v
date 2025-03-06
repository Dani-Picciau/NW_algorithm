`include "C:\..."
 
module AB_manager #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    input wire [2:0] din_ram, // data in, to be written
    input wire en_ram, 
    input wire weA, weB, 
    input wire [BitAddr:0] addr_dinA, addr_dinB,
    input wire change_index,
    input wire en_traceB, en_read, clk, rst,
    input wire [BitAddr:0] i, i_t, j, j_t,
    output wire [2:0] doutA,doutB
);
    wire [BitAddr:0] indexA ,indexB;
    
    RAM_A #(
        .N(N)
    ) ramA (
        .clk(clk),
        .rst(rst),
        .din(din_ram),
        .en_din(en_ram),
        .we(weA),
        .addr_din(addr_dinA),
        .en_dout(en_traceB||(en_read && !change_index)),
        .addr_dout(indexA),
        .dout(doutA)
    );
    
    RAM_B #(
        .N(N)
    ) ramB (
        .clk(clk),
        .rst(rst),
        .din(din_ram),
        .en_din(en_ram),
        .we(weB),
        .addr_din(addr_dinB),
        .en_dout(en_traceB||(en_read && !change_index)),
        .addr_dout(indexB),
        .dout(doutB)
    );
    
    Index_out_A #(
        .N(N)
    ) I_o_A (
        .en_traceB(en_traceB),
        .en_read(en_read),
        .change_index(change_index),
        .i(i),
        .i_t(i_t),
        .index(indexA)
    );
    
    Index_out_B #(
        .N(N)
    ) I_o_B (
        .en_traceB(en_traceB),
        .en_read(en_read),
        .change_index(change_index),
        .j(j),
        .j_t(j_t),
        .index(indexB)
    );
    
    //end
endmodule