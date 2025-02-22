module Max #(
    parameter gap_score = -2,
    parameter match_score = 1,
    parameter mismatch_score = -1,
    parameter arrow_lx = 3'b100,
    parameter arrow_up = 3'b010, 
    parameter arrow_diag = 3'b001
) (
    input wire value, clk, rst,
    input wire signed [8:0] diag, up, lx,
    output reg signed [8:0] max,
    output reg [2:0] symbol,
    output reg calculated
);
    
    // Registri per i calcoli intermedi
    reg signed [8:0] diag_calc, up_calc, lx_calc;
    
    // Wire per i risultati della logica combinatoria
    reg signed [8:0] next_max;
    reg [2:0] next_symbol;
    reg next_calculated;
    
    // Logica sequenziale per l'aggiornamento dei registri
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            max <= 255;
            symbol <= 0;
            calculated <= 1'b0;
        end
        else begin
            max <= next_max;
            symbol <= next_symbol;
            calculated <= next_calculated;
        end
    end
    
    // Logica combinatoria per i calcoli
    always @(value, diag, up, lx, max, symbol) begin
        // Calcolo dei valori
        if(value) diag_calc = diag + match_score;
        else diag_calc = diag + mismatch_score;
            
        up_calc = up + gap_score;
        lx_calc = lx + gap_score;
        
        // Default values
        next_max = max;
        next_symbol = symbol;
        next_calculated = 1'b0;
        
        if(diag == 255 || up == 255 || lx == 255) begin
            next_calculated = 1'b0;
        end
        else begin
            next_calculated = 1'b1;
            
            if (diag_calc > up_calc && diag_calc > lx_calc) begin
                next_symbol = arrow_diag;
                next_max = diag_calc;
            end
            else if (up_calc > diag_calc && up_calc > lx_calc) begin
                next_symbol = arrow_up;
                next_max = up_calc;
            end
            else if (lx_calc > diag_calc && lx_calc > up_calc) begin
                next_symbol = arrow_lx;
                next_max = lx_calc;
            end
            else if (diag_calc == up_calc && diag_calc == lx_calc) begin
                if (diag >= up && diag >= lx) begin
                    next_symbol = arrow_diag;
                    next_max = diag_calc;
                end
                else if (up >= diag && up >= lx) begin
                    next_symbol = arrow_up;
                    next_max = up_calc;
                end
                else begin
                    next_symbol = arrow_lx;
                    next_max = lx_calc;
                end
            end
            else if (diag_calc == up_calc) begin
                if (diag >= up) begin
                    next_symbol = arrow_diag;
                    next_max = diag_calc;
                end
                else begin
                    next_symbol = arrow_up;
                    next_max = up_calc;
                end
            end
            else if (diag_calc == lx_calc) begin
                if (diag >= lx) begin
                    next_symbol = arrow_diag;
                    next_max = diag_calc;
                end
                else begin
                    next_symbol = arrow_lx;
                    next_max = lx_calc;
                end
            end
            else if (up_calc == lx_calc) begin
                if (up >= lx) begin
                    next_symbol = arrow_up;
                    next_max = up_calc;
                end
                else begin
                    next_symbol = arrow_lx;
                    next_max = lx_calc;
                end
            end
        end
    end
endmodule