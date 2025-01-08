`include "C:\Users\crist\Desktop\GitHUb\Progetto ESD\NW_algorithm\Verilog\UART"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: testbench
//////////////////////////////////////////////////////////////////////////////////


module tb_tx;
	parameter 
		DATA_BW=8, 
		DATA_BW_BIT=4, 
		BAUD_RATE=9600,
		BAUD_COUNT=10416, //with BAUD_RATE 9600bps and system clk 100MHz --> baud rate counter is 10416 represented with N_BIT=14
		BAUD_BIT=14;
			  
	reg clk, rst;
	reg transmit;
	reg [DATA_BW-1:0] input_data;
	wire TX; 
	wire busy;
				   
	top_tx #(.DATA_BW(DATA_BW), .DATA_BW_BIT(DATA_BW_BIT),
				.BAUD_RATE(BAUD_RATE), .BAUD_COUNT(BAUD_COUNT),
	 			.BAUD_BIT(BAUD_BIT))
			DUT(.clk(clk), .rst(rst), .transmit(transmit),
			 .data_in(input_data),.TX(TX), .busy(busy))	

	//generazione clock simulazione
	always #5 clk=~clk;

	//dinamica segnali
	initial
		begin
			clk=1'b0;
			rst=1'b0;
			transmit=1'b0;
			input_data=8'b00010101;
			#100
			rst=1'b1;
			#100
			rst=1'b0;
			#100
			SendSingleByte(8'hC1);
			SendSingleByte(8'hBE);
			SendSingleByte(8'hEF);
			#1000
			$stop;
		end

	task SendSingleByte;
		input [7:0] data; //data da trasmettere  
			begin
				@(negedge clk)
				//byte trasmesso alla UART sollevando il transmit contestualmente
				input_data <= data; 
				transmit   <= 1'b1; 
				@(negedge clk)
				transmit <= 1'b0; // il transmit rimane alto un colpo di clock 
				/*non si esce dal task (quindi non si abilitano potenzialmente nuove transazioni) 
				fino a che la UART non � di nuovo disponibile*/
				@(negedge busy); 
			end
	endtask

endmodule