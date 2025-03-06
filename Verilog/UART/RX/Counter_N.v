`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2025 18:26:04
// Design Name: 
// Module Name: Counter_N
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Counter_data_N #(parameter N = 9 )(
    input wire clk, rst, 
    input wire data_ready,
    output reg hit
);
    reg [3:0] counter, counter_next;
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            counter <= 0;
        end 
        else begin
            counter <= counter_next;
        end
    end

    always @(data_ready, counter) begin
        if (data_ready && counter < N) begin
            counter_next = counter + 1;
            hit = 0;
        end
        else if (counter >= N) begin
            counter_next = counter;
            hit = 1;
        end 
        else begin
            counter_next = counter;
            hit = 0;
        end
    end
endmodule

module Counter_btn (
    input wire clk, rst, 
    input wire en_btn,
    output reg btn
);
    reg [1:0] counter, counter_next;
    reg btn_next;
    
    always @(posedge clk, posedge rst) begin
        if(rst) counter <= 0;
        else counter <= counter_next;
    end
    
    always @(posedge clk, posedge rst) begin
        if(rst) btn <= 0;
        else btn <= btn_next;
    end
    
    always @(en_btn, btn, counter) begin
       if(en_btn) begin
            if(counter == 0) begin
                counter_next = counter + 1;
                btn_next = 0;
            end
            else if(counter == 1) begin
                counter_next <= counter + 1;
                btn_next = 1;
            end
            else if(counter == 2) begin
                counter_next <= counter + 1;
                btn_next <= 1;
            end
            else begin
                counter_next <= 0;
                btn_next <= 0;
            end
        end
        else begin
            counter_next <= 0;
            btn_next <= 0;
        end
    end
endmodule