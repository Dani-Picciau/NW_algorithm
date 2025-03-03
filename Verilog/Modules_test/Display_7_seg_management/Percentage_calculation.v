module Percentage_calculation #(
    parameter N = 128
) (
    input wire signed [8:0] final_score,
    output reg [8:0] percentage
);
    always @(final_score) begin
        if(percentage == 255) percentage = 255;
        else percentage = ((final_score + N)*100) / (2 * N);
    end

    //end
endmodule