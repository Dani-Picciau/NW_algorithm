module Index_out_A #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    //input wire clk, rst,
    input wire en_traceB, en_read,
    input wire change_index,
    input wire [BitAddr:0] i, i_t,
    output reg [BitAddr:0] index
);

    always @(en_traceB, en_read, i, i_t, change_index) begin
        if(en_read && !change_index) index=i;
        else if(en_traceB) index=i_t;
        else index={(BitAddr+1){1'b0}}; // cercare un indice che non faccia danno
    end
    
    //end
endmodule