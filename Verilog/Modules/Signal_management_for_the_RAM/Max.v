module Max #(
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1
) (
    input wire value, clk, rst,
    input wire signed [8:0] diag, up, lx, //9 bits to include values ??from +128 to -128
    output reg signed [8:0] max, //9 bits to include values ??from +128 to -128
    output reg [2:0] symbol, // <-, ?, ?
    output reg calculated
);
    parameter arrow_lx = 3'b100, arrow_up = 3'b010, arrow_diag = 3'b001;
    reg signed [8:0] diag_calc, up_calc, lx_calc;

    always @(posedge clk, posedge rst, value, diag, up, lx) begin
        
        if(rst) begin
            max = 255;
            symbol = 0;
            calculated = 1'b0;
            diag_calc = 255;
            up_calc = 255;
            lx_calc = 255;
        end
        else begin
            if(value) diag_calc = diag + match_score;
            else diag_calc = diag + mismatch_score;

            up_calc = up + gap_score;
            lx_calc = lx + gap_score;

            if(diag == 255 || up == 255 || lx == 255)  calculated = 1'b0;
            else begin
                if (diag_calc > up_calc && diag_calc > lx_calc) begin //if the diagonal is the greatest
                    symbol <= arrow_diag; 
                    max <= diag_calc;
                    calculated <= 1'b1;
                end 
                else if (up_calc > diag_calc && up_calc > lx_calc) begin //if the up is the greatest
                    symbol <= arrow_up; 
                    max <= up_calc;
                    calculated <= 1'b1;
                end 
                else if (lx_calc > diag_calc && lx_calc > up_calc) begin //if the left is the greatest
                    symbol <= arrow_lx; 
                    max <= lx_calc;
                    calculated <= 1'b1;
                end 
                else if (diag_calc == up_calc && diag_calc == lx_calc) begin //if all are equal
                    if (diag >= up && diag >= lx) begin //if, compared to the basic values, the diagonal is the greatest
                        symbol <= arrow_diag; 
                        max <= diag_calc;
                    end else if (up >= diag && up >= lx) begin //if, compared to the basic values, the up is the greatest
                        symbol <= arrow_up; 
                        max <= up_calc;
                    end else begin //if, compared to the basic values, the left is the greatest
                        symbol <= arrow_lx; 
                        max <= lx_calc;
                    end
                    calculated <= 1'b1;
                end 
                else if (diag_calc == up_calc) begin //if the diagonal and the up are equal
                    if (diag >= up) begin //if, compared to the basic values, the diagonal is the greatest
                        symbol <= arrow_diag; 
                        max <= diag_calc;
                    end else begin //if, compared to the basic values, the up is the greatest
                        symbol <= arrow_up; 
                        max <= up_calc;
                    end
                    calculated <= 1'b1;
                end 
                else if (diag_calc == lx_calc) begin //if the diagonal and the left are equal
                    if (diag >= lx) begin //if, compared to the basic values, the diagonal is the greatest
                        symbol <= arrow_diag; 
                        max <= diag_calc;
                    end else begin //if, compared to the basic values, the left is the greatest
                        symbol <= arrow_lx; 
                        max <= lx_calc;
                    end
                    calculated <= 1'b1;
                end 
                else if (up_calc == lx_calc) begin //if, the up and the left are equal
                    if (up >= lx) begin //if, compared to the basic values, the up is the greatest
                        symbol <= arrow_up; 
                        max <= up_calc;
                    end else begin //if, compared to the basic values, the left is the greatest
                        symbol <= arrow_lx; 
                        max <= lx_calc;
                    end
                    calculated <= 1'b1;
                end
            end
        end
    end
endmodule