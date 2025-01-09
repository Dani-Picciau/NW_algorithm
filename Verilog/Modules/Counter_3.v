module Counter_3 (
    input wire clk, rst,
    input wire en,
    output reg signal,
    output reg [1:0] count
);
    reg [1:0] count_next;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            count <= 0;
            signal <= 0;
        end
        else count <= count_next;
    end

    always @(posedge clk) begin
        if(count == 2'b10) begin
            signal = 1'b1;
            count_next <= 0;
        end 
        else count_next <= count + 1;
    end
endmodule