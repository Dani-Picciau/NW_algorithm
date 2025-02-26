`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2025 12:22:36
// Design Name: 
// Module Name: counter
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


module counter 
#(
	parameter MAX=10,
    parameter N_BIT=4)
(
	input wire clk, rst,
	input wire en,
	output reg [N_BIT-1:0] count
);
    
	reg [N_BIT-1:0] count_nxt;

	always@(posedge clk, posedge rst)
		if(rst==1'b1) count<={N_BIT{1'b0}};
		else count<=count_nxt;  

	always@(en,count)
		if(en==1'b0) count_nxt=count;
		else if(count==MAX-1) count_nxt={N_BIT{1'b0}};
			else count_nxt=count+1;
	 
endmodule