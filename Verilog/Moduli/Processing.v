module Processing #(
    parameter N = 128,
    parameter score_length = $clog2(N),
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire [2:0] SeqA_i_t,
    input wire [2:0] SeqB_j_t,
    input wire [2:0] symbol_in,
    output reg [score_length:0] score,
    output reg [2:0] datoA,
    output reg [2:0] datoB
);
    parameter dash = 3'b111;
    reg [score_length:0] score_next;

    //Register for the output score...
    always @(posedge clk, posedge rst) begin
        if(rst) score <= 0;
        else score <= score_next;
    end

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            datoA <= 0;
            datoB <= 0;
        end 
        else begin
            case (symbol_in)
                3'b001: begin // Diagonal arrow ↖
                    datoA <= SeqA_i_t;
                    datoB <= SeqB_j_t;
                    if(datoA == datoB) score_next <= score + match_score;
                end
                3'b100: begin // Left arrow ↖
                    datoA <= dash;
                    datoB <= SeqB_j_t;
                    score_next <= score + mismatch_score;
                end
                3'b010: begin // Up arrow ⭡
                    datoA <= SeqA_i_t;
                    datoB <= dash;
                    score_next <= score + mismatch_score;
                end
                default: begin
                    datoA <= 0;
                    datoB <= 0;
                end
            endcase
        end
    end
endmodule