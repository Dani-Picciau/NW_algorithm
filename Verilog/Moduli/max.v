module max #(
    parameter gap = -1
) (
    input wire value, clk,
    input wire [8:0] diag, up, lx, //9 bit per comprendere i valori da +128 a -128
    output reg [8:0] max, //9 bit per comprendere i valori da +128 a -128
    output reg [2:0] symbol, // <-, ↖, ⭡
    output reg calculated
);
    reg [8:0] diag_calc, up_calc, lx_calc;

    always @(posedge clk, value, diag, up, lx) begin
        calculated = 1'b0;

        if(value) diag_calc = diag +1;
        else diag_calc = diag-1;
        up_calc = up + gap;
        lx_calc = lx + gap;

        if (diag_calc > up_calc && diag_calc > lx_calc) begin
            symbol = 3'b001; 
            max = diag_calc;
            calculated = 1'b1;
        end else if (up_calc > diag_calc && up_calc > lx_calc) begin
            symbol = 3'b010; 
            max = up_calc;
            calculated = 1'b1;
        end else if (lx_calc > diag_calc && lx_calc > up_calc) begin
            symbol = 3'b100; 
            max = lx_calc;
            calculated = 1'b1;
        end else if (diag_calc == up_calc && diag_calc == lx_calc) begin
            if (diag >= up && diag >= lx) begin
                symbol = 3'b001; 
                max = diag_calc;
                calculated = 1'b1;
            end else if (up >= diag && up >= lx) begin
                symbol = 3'b010; 
                max = up_calc;
                calculated = 1'b1;
            end else begin
                symbol = 3'b100; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end else if (diag_calc == up_calc) begin
            if (diag >= up) begin
                symbol = 3'b001; 
                max = diag_calc;
                calculated = 1'b1;
            end else begin
                symbol = 3'b010; 
                max = up_calc;
                calculated = 1'b1;
            end
        end else if (diag_calc == lx_calc) begin
            if (diag >= lx) begin
                symbol = 3'b001; 
                max = diag_calc;
                calculated = 1'b1;
            end else begin
                symbol = 3'b100; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end else if (up_calc == lx_calc) begin
            if (up >= lx) begin
                symbol = 3'b010; 
                max = up_calc;
                calculated = 1'b1;
            end else begin
                symbol = 3'b100; 
                max = lx_calc;
                calculated = 1'b1;
            end
        end
    end
endmodule
