module Splitter (
    input wire [8:0] Percentage,  // Input number (max 99)
    output reg [4:0] Tens,    // Tens digit
    output reg [3:0] Units    // Units digit
);
    always@(Percentage) begin
        Tens = Percentage / 10;
        Units = Percentage % 10;
    end    
    //end
endmodule
