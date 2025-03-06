module Index_out_B #(
    parameter N=128,
    parameter BitAddr=$clog2(N+1)
)(
    //input wire clk, rst,
    input wire en_traceB, en_read,
    input wire change_index,
    input wire [BitAddr:0] j, j_t,
    output reg [BitAddr:0] index
);

    always @(en_traceB, en_read, j, j_t, change_index) begin
        if(en_read && !change_index) index=j;
        else if(en_traceB) index=j_t;
        else index={(BitAddr+1){1'b0}}; // cercare un indice che non faccia danno
    end
    
    //end
endmodule