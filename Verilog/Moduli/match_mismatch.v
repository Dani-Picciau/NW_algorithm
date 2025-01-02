module match_mismatch(
    input wire [2:0] a,     
    input wire [2:0] b,     
    output reg  value
);
    always @(a,b) begin
        if (a == b) value = 1'b1; 
        else value = 1'b0;  
    end
endmodule
