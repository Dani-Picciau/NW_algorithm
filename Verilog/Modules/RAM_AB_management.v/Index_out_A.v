module Index_out_A #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    //input wire clk, rst,
    input wire en_traceB, en_read,
    input wire [BitAddr-1:0] i, i_t,
    output reg [BitAddr-1:0] index
);

    always @(en_traceB, en_read ) begin
        if(en_read) index=i;
        else if(en_traceB) index=i_t;
        else index=3'b0; // cercare un indice che non faccia danno
    end
    
endmodule