module Counter_3 (
    input wire clk, rst,
    input wire en,
    output reg signal,
    output reg [1:0] count
);
    reg [1:0] count_next;
    reg [1:0] cnt_clk, cnt_clk_nxt;

    //Register to count the clock
    always @(posedge clk, posedge rst) begin
        if(rst) cnt_clk <= 0;
        else cnt_clk <= cnt_clk_nxt;
    end

    //Register to increase the count
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            count <= 0;
            signal <= 0;
        end
        else count <= count_next;
    end

    always @(posedge clk) begin
        if(en) begin
            if(count == 2'b10) begin
                signal = 1'b1;
                count_next <= 0;
            end 
            else begin
                if(cnt_clk == 2'b10) begin
                    count_next <= count + 1;
                    cnt_clk_nxt <= 0;
                end
                else begin
                    cnt_clk_nxt <= cnt_clk + 1;
                    count_next <= count;
                end
            end
        end
    end
endmodule