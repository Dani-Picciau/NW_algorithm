`timescale 1ns / 1ps
`include "C:\..."
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2023 09:37:23
// Design Name: 
// Module Name: baud_rate_generator
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


module baud_rate_clk_gen 
#(
	parameter BAUD_CNT=10416,
    parameter BAUD_BIT=14
)(
	input wire clk, rst,
	output reg baud_clk
);
	wire [BAUD_BIT-1:0] count;
		
	counter #(.MAX(BAUD_CNT), .N_BIT(BAUD_BIT)) CNT_BAUD(.clk(clk), .rst(rst), .en(1'b1), .count(count));

	always@(posedge clk, posedge rst)
		if(rst==1'b1) baud_clk <=1'b0;
		else if(count<BAUD_CNT/2) baud_clk <=1'b1; 
			else baud_clk <=1'b0; 

endmodule