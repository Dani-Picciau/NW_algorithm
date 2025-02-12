`include "c:\..."

module Top_RAM #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    input wire en_traceB,en_read,clk,rst,
    input wire [BitAddr-1:0] i,i_t,j,j_t,
    output wire [2:0] doutA,doutB,  
    output wire [BitAddr-1:0] indexA ,indexB
    
    );
    
    
    RAM_A #(
        .N(N)
    ) ramA (
        .clk(clk),
        .rst(rst),
        .en_dout(en_traceB||en_read),
        .addr_dout(indexA),
        .dout(doutA)
    );
    
        
    RAM_B #(
        .N(N)
    ) ramB (
        .clk(clk),
        .rst(rst),
        .en_dout(en_traceB||en_read),
        .addr_dout(indexB),
        .dout(doutB)
    );
    
    Index_out_A #(
        .N(N)
    ) ioA (
        .en_traceB(en_traceB),
        .en_read(en_read),
        .i(i),
        .i_t(i_t),
        .index(indexA)
    );
    
    
    Index_out_B #(
        .N(N)
    ) ioB (
        .en_traceB(en_traceB),
        .en_read(en_read),
        .j(j),
        .j_t(j_t),
        .index(indexB)
    );
    
    //
endmodule
