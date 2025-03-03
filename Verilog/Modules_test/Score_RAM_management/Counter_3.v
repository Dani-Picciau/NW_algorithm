module Counter_3 (
    input wire clk, rst,
    input wire en,
    output reg signal,
    output reg [1:0] count
);
    reg [1:0] count_next;
    reg [1:0] cnt_clk, cnt_clk_nxt;
    reg signal_next; 

    // Register per clock counter
    always @(posedge clk, posedge rst) begin
        if(rst) cnt_clk <= 0;
        else cnt_clk <= cnt_clk_nxt;
    end

    // Register per count e signal
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            count <= 0;
            signal <= 0;
        end
        else begin
            count <= count_next;
            signal <= signal_next;
        end
    end

    // continue module Counter_3
    always @(en, count, cnt_clk) begin
        if(en) begin
            if(cnt_clk == 2'b11) begin
                cnt_clk_nxt = 0;
                if(count == 2'b10) begin
                    signal_next = 1'b1;
                    count_next = 0;    
                end 
                else begin 
                    signal_next = 1'b0;
                    count_next = count + 1;
                end
            end
            else begin
                cnt_clk_nxt = cnt_clk + 1;
                count_next = count;
                signal_next = 1'b0;
            end
        end else begin
            count_next = 0;
            signal_next = 0;
            cnt_clk_nxt = 0;
        end
    end
endmodule
