`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: registro
//////////////////////////////////////////////////////////////////////////////////

module register 
#(
	parameter N=16
)(
	input wire [N-1:0] D,
	input wire load,
	input wire clk, rst,
	output reg [N-1:0] Q 
);
     
	always@(posedge clk, posedge rst)
		if (rst==1'b1) Q<={N{1'b0}};
		else if(load==1'b1) Q<=D;   
 
endmodule