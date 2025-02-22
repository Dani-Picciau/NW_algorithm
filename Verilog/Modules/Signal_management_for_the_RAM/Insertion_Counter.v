module Insertion_counter # (
    parameter N = 128,
    parameter BitAddr = $clog2(N+1)
)(
    input wire clk, rst,
    input wire en_read,
    input wire change_index,
    output wire end_filling,
    output reg [BitAddr:0] i, j
);
    reg [BitAddr-1:0] count_nxtJ; 
    reg [BitAddr-1:0] count_nxtI;
    
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

        count_nxtI = i;
        count_nxtJ = j;
        
        if (en_read) begin
            if (change_index) begin
                if (j == N-1) begin
                    count_nxtJ = 0;
                    if (i < N-1) begin
                        count_nxtI = i + 1;
                    end
                    else begin
                        count_nxtI = 0;
                    end
                end
                else begin
                    count_nxtJ = j + 1;
                end
            end
        end
    end

    // End filling signal
    assign end_filling = (en_read==0 && i == N-1 && j == N-1) ? 1'b1 : 1'b0;
endmodule