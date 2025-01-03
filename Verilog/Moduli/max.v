module max #(
    parameter gap = -1
) (
    input wire value, clk,
    input wire [8:0] diag, up, lx, //9 bits to include values ​​from +128 to -128
    output reg [8:0] max, //9 bits to include values ​​from +128 to -128
    output reg [2:0] symbol, // <-, ⭡, ↖
    output reg calculated
);
    parameter arrow_lx = 3'b100, arrow_up = 3'b010, arrow_diag = 3'b001;
    reg [8:0] diag_calc, up_calc, lx_calc;

    always @(posedge clk, value, diag, up, lx) begin
        calculated = 1'b0;

        if(value) diag_calc = diag +1;
        else diag_calc = diag-1;
        up_calc = up + gap;
        lx_calc = lx + gap;


        if (diag_calc > up_calc && diag_calc > lx_calc) begin //if the diagonal is the greatest
            symbol = arrow_diag; 
            max = diag_calc;
            calculated = 1'b1;
        end 
        else if (up_calc > diag_calc && up_calc > lx_calc) begin //if the up is the greatest
            symbol = arrow_up; 
            max = up_calc;
            calculated = 1'b1;
        end 
        else if (lx_calc > diag_calc && lx_calc > up_calc) begin //if the left is the greatest
            symbol = arrow_lx; 
            max = lx_calc;
            calculated = 1'b1;
        end 
        else if (diag_calc == up_calc && diag_calc == lx_calc) begin //if all are equal
            if (diag >= up && diag >= lx) begin //if, compared to the basic values, the diagonal is the greatest
                symbol = arrow_diag; 
                max = diag_calc;
                calculated = 1'b1;
            end else if (up >= diag && up >= lx) begin //if, compared to the basic values, the up is the greatest
                symbol = arrow_up; 
                max = up_calc;
                calculated = 1'b1;
            end else begin //if, compared to the basic values, the left is the greatest
                symbol = arrow_lx; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end 
        else if (diag_calc == up_calc) begin //if the diagonal and the up are equal
            if (diag >= up) begin //if, compared to the basic values, the diagonal is the greatest
                symbol = arrow_diag; 
                max = diag_calc;
                calculated = 1'b1;
            end else begin //if, compared to the basic values, the up is the greatest
                symbol = arrow_up; 
                max = up_calc;
                calculated = 1'b1;
            end
        end 
        else if (diag_calc == lx_calc) begin //if the diagonal and the left are equal
            if (diag >= lx) begin //if, compared to the basic values, the diagonal is the greatest
                symbol = arrow_diag; 
                max = diag_calc;
                calculated = 1'b1;
            end else begin //if, compared to the basic values, the left is the greatest
                symbol = arrow_lx; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end 
        else if (up_calc == lx_calc) begin //if, the up and the left are equal
            if (up >= lx) begin //if, compared to the basic values, the up is the greatest
                symbol = arrow_up; 
                max = up_calc;
                calculated = 1'b1;
            end else begin //if, compared to the basic values, the left is the greatest
                symbol = arrow_lx; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end
    end
endmodule
