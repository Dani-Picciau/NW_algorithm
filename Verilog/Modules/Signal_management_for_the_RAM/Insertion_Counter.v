module Insertion_Counter #(
    parameter N = 128
)(
    input wire clk, rst,
    input wire en_read,
    input wire change_index,
    output wire end_filling,
    output reg [($clog2(N)):0] i, j
);
    reg [($clog2(N)):0] count_nxtJ; 
    reg [($clog2(N)):0] count_nxtI;
    
    // Sequential logic for registers
    always @(posedge clk, posedge rst) begin
        if (rst) begin 
            i <= 0;
            j <= 0;
        end
        else begin
            i <= count_nxtI;
            j <= count_nxtJ;
        end 
    end

    // Combinational logic for next state
    always @(i, j, en_read, change_index) begin
        // Default: keep current values
        count_nxtI = i;
        count_nxtJ = j;
        
        if (en_read) begin
            if (change_index) begin
                if (j == N-1) begin
                    // When j reaches N-1, reset j and increment i
                    count_nxtJ = 0;
                    if (i < N-1) begin
                        count_nxtI = i + 1;
                    end
                    else begin
                        // Reset i quando raggiungiamo N-1
                        count_nxtI = 0;
                    end
                end
                else begin
                    // Normal j increment
                    count_nxtJ = j + 1;
                end
            end
        end
    end

    // End filling signal
    assign end_filling = (en_read && i == N-1 && j == N-1) ? 1'b1 : 1'b0;
endmodule
