module Counter_3 (
    input wire clk, rst,
    input wire en,
    input wire stop_count,
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
        else if(!stop_count) count_next <= count + 1;
        else count_next <= count;
    end
endmodule