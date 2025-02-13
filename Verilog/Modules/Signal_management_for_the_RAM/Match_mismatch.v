module Match_mismatch(
    input wire clk, rst, 
    input wire en_read,
    input wire [2:0] a,     
    input wire [2:0] b,     
    output reg  value
);
    reg value_next;

    always @(posedge clk ) begin
        if(rst) value <= 0;
        else value <= value_next;
    end

    always @(a,b) begin
        if (en_read) begin
            if (a == b) value_next <= 1'b1; 
            else value_next <= 1'b0;
        end
        else value_next <= value;  
    end

    //end
endmodule
