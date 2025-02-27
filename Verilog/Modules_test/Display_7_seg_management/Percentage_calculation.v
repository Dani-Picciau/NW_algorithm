module Percentage_calculation #(
    parameter N = 5,
    parameter score_lenght = $clog2(N+1)
) (
    input wire signed [score_lenght:0] final_score,
    output reg [7:0] percentage
);
    always @(final_score) begin
         percentage = ((final_score + N)*100) / (2 * N);
    end

    //end
endmodule