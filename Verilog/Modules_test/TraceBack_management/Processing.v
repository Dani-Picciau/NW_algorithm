module Processing #(
    parameter N = 128,
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1,
    parameter dash = 3'b111
) (
    input wire clk, rst,
    input wire en_traceB,
    input wire [2:0] SeqA_i_t,
    input wire [2:0] SeqB_j_t,
    input wire [2:0] symbol,
    output reg signed [8:0] final_score,
    output reg [2:0] datoA,
    output reg [2:0] datoB
);
    reg signed [8:0] score_next, score_next_comb;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score_next <= 0;
            final_score <= 255;
        end 
        else if (en_traceB) begin
            score_next <= 0;
            final_score <= score_next_comb;
        end
        else score_next <= score_next_comb;
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            datoA <= 0;
            datoB <= 0;
        end 
        else begin
            if (en_traceB) begin
                case (symbol)
                    3'b001: begin // Diagonal arrow \
                        datoA <= SeqA_i_t;
                        datoB <= SeqB_j_t;
                    end
                    3'b100: begin // Left arrow <-
                        datoA <= dash;
                        datoB <= SeqB_j_t;
                    end
                    3'b010: begin // Up arrow ^
                        datoA <= SeqA_i_t;
                        datoB <= dash;
                    end
                    default: begin
                        datoA <= 0;
                        datoB <= 0;
                    end
                endcase
            end
            else begin
                datoA <= 0;
                datoB <= 0;
            end
        end
    end

    always @(datoA, datoB) begin
        if (en_traceB) begin
            case (symbol)
                3'b001: begin // Diagonal arrow \
                    if (datoA == datoB) score_next_comb = final_score + match_score;
                    else score_next_comb = final_score + mismatch_score;
                end
                3'b100: score_next_comb = final_score + gap_score; // Left arrow <-
                3'b010: score_next_comb = final_score + gap_score; // Up arrow ^
                default: score_next_comb = final_score;
            endcase
        end
        else score_next_comb = score_next;
    end
    
    //end
endmodule