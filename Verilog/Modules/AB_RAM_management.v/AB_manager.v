`include "c:\..."

`include "Index_out_A.v"
`include "Index_out_B.v"
`include "RAM_A.v"
`include "RAM_B.v"

module AB_manager #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    input wire change_index,
    input wire en_traceB,en_read,clk,rst,
    input wire [BitAddr:0] i,i_t,j,j_t,
    output wire [2:0] doutA,doutB,  
    
    //Internal wires
    output wire [BitAddr:0] indexA ,indexB
);
    
    RAM_A #(
        .N(N)
    ) ramA (
        .clk(clk),
        .rst(rst),
        .en_dout(en_traceB||(en_read && !change_index)),
        .addr_dout(indexA),
        .dout(doutA)
    );
    
    RAM_B #(
        .N(N)
    ) ramB (
        .clk(clk),
        .rst(rst),
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