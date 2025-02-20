module Processing #(
    parameter N = 128,
    parameter score_length = $clog2(N+1),
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire clk, rst,
    input wire en_traceB,
    input wire [2:0] SeqA_i_t,
    input wire [2:0] SeqB_j_t,
    input wire [2:0] symbol,
    output reg signed [score_length:0] final_score,
    output reg [2:0] datoA,
    output reg [2:0] datoB
);
    parameter dash = 3'b111;
    reg signed [score_length:0] score_next;

    //Register for the output score...
    always @(posedge clk, posedge rst) begin
        if(rst) final_score <= 0;
        else final_score <= score_next;
    end

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            datoA <= 0;
            datoB <= 0;
        end 
        else begin
            if(en_traceB) begin
                case (symbol)
                    3'b001: begin // Diagonal arrow ?
                        datoA <= SeqA_i_t;
                        datoB <= SeqB_j_t;
                    end
                    3'b100: begin // Left arrow ?
                        datoA <= dash;
                        datoB <= SeqB_j_t;
                    end
                    3'b010: begin // Up arrow ?
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

    always @(posedge rst, datoA, datoB) begin
        if(rst) score_next = 0;
        else begin
            if(en_traceB) begin
                case (symbol)
                    3'b001: begin // Diagonal arrow ?
                        if(datoA == datoB) score_next = final_score + match_score;
                        else score_next = final_score + mismatch_score;
                    end
                    3'b100: score_next = final_score + gap_score; // Left arrow ?
                    3'b010: score_next = final_score + gap_score; // Up arrow ?
                    default: score_next = final_score;
                endcase
            end
            else score_next = 0;
        end
    end
    
    //end
endmodule
