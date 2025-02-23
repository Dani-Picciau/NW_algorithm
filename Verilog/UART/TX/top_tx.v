`include "C:\Users\crist\Desktop\GitHUb\Progetto ESD\NW_algorithm\Verilog\UART"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: top trasmissione
//////////////////////////////////////////////////////////////////////////////////


module top_tx #(parameter
	DATA_BITS = 8, 
	STOP_TICK = 16,
	N=10,
	COUNT=651,
	DATA_SIZE = 8,
	ADDR_SIZE_EXP = 4
	)(
	input wire clk, rst,
	input wire wrA, wrB, btnA, btnB,
	input wire [3-1:0] data_A, data_B,
	output wire A_full, B_full, A_empty, B_empty
	output wire txA, txB
	);

	wire tick, tx_done_A, tx_done_B;
	wire not_emptyA, not_emptyB;
	wire txgo_A, txgo_B;
	wire [DATA_BITS-1:0] data_A_tot, data_B_tot, data_A_out, data_B_out;
	baud_rate_generator #(.N(N), .COUNT(COUNT)) br_g (.clk(clk), rst(rst), .tick(tick));

	cod_out #(.N(DATA_BITS)) cod_out_A (.clk(clk), .rst(rst), .char(data_A), .Txdata_in(data_A_tot));

	cod_out #(.N(DATA_BITS)) cod_out_B (.clk(clk), .rst(rst), .char(data_B), .Txdata_in(data_B_tot));

	fifo #(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE_EXP(ADDR_SIZE_EXP)) fifo_A (.clk(clk), .rst(rst), .rd_from_fifo(tx_done_A), .wr_to_fifo(wrA),
		.wr_data_in(data_A_tot), .rd_data_out(data_A_out), .empty(A_empty), .full(A_full));

	assign not_emptyA=~A_empty;
	
	fifo #(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE_EXP(ADDR_SIZE_EXP)) fifo_B (.clk(clk), .rst(rst), .rd_from_fifo(tx_done_B), .wr_to_fifo(wrB),
		.wr_data_in(data_B_tot), .rd_data_out(data_B_out), .empty(B_empty), .full(B_full));

	assign not_emptyB=~B_empty;

	assign txgo_A= not_emptyA & btnA;
	assign txgo_B= not_emptyB & btnB;

	uart_transmitter #(.DATA_BITS(DATA_BITS), .STOP_TICK(STOP_TICK)) tx_A (.clk(clk), .rst(rst), .tx_start(txgo_A), .sample_tick(tick),
		.data_in(data_A_out), .tx_done(tx_done_A), .tx_data(tx_A));

	uart_transmitter #(.DATA_BITS(DATA_BITS), .STOP_TICK(STOP_TICK)) tx_A (.clk(clk), .rst(rst), .tx_start(txgo_B), .sample_tick(tick),
		.data_in(data_B_out), .tx_done(tx_done_B), .tx_data(tx_B));
		
endmodule
