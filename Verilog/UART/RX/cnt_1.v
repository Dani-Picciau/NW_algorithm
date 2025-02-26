`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2025 15:04:11
// Design Name: 
// Module Name: cnt_1
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

module Counter_1(
    input wire clk, rst,
    input wire en_init,
    output reg hit
);
    reg hit_n; 

    always @(posedge clk, posedge rst) begin
        if(rst) hit <= 0;
        else hit <= hit_n;
    end

    always @(posedge clk) begin
        if(en_init) begin
            if(!hit) hit_n <= hit +1;
            else hit_n <=0;
        end
        else hit_n<=0;
    end
endmodule