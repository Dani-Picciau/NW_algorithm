`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: generatore clock dipendente dal baud rate
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