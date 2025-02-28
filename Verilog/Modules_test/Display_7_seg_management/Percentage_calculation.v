module Percentage_calculation #(
    parameter N = 128
) (
    input wire signed [8:0] final_score,
    output reg [8:0] percentage
);
    always @(final_score) begin
        percentage = ((final_score + N)*100) / (2 * N);
    end

    //end
endmodule