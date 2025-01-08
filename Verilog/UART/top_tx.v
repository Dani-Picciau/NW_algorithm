`include "C:\Users\crist\Desktop\GitHUb\Progetto ESD\NW_algorithm\Verilog\UART"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Sassari
// Engineer: Claudio Rubattu
// Email: crubattu@uniss.it
// Description: top trasmissione
//////////////////////////////////////////////////////////////////////////////////


module top_tx 
#(
	parameter DATA_BW=8,        	// N bit di informazione
	parameter DATA_BW_BIT=4,    	// Config. CONTATORE bit info
	parameter BAUD_RATE=9600,   	// Baud Rate
	parameter BAUD_COUNT=10416, 	// Clk Cycles (CC) per Baud Rate (BR)
	parameter BAUD_BIT=14       	// Config. CONTATORE CC per BR
)(
	input wire clk, rst,           	// segnali di controllo generali 
	input wire transmit,           	// richiesta di trasmissione
	input wire [DATA_BW-1:0] data, 	// data_chunk da trasferire
	output wire TX,                	// porta seriale di trasmissione
	output reg busy               	// "flag" di stato occupato
);
    
	//gestione dei registri di input
	/*segnale di abilitazione campionamento dato da trasmettere: 
	ALTO se il produttore richiede una trasmissione (transmit=1) e la UART non � attualmente gi� impegnata in una trasmissione (busy=0)*/
	wire en_in;
	/*dato campionato*/
	wire [DATA_BW-1:0] data_stored;

	//gestione contatore dati trasmessi
	/*FSM-->CONTATORE segnale di abilitazione del contatore di dati trasmessi*/
	wire en;
	/*CONTATORE-->FSM conteggio dati*/
	wire [DATA_BW_BIT-1:0] count; 
	/*CONTATORE-->FSM segnala (hit=1) la trasmissione dell'ultimo bit di informazione*/
	wire hit; 

	//segnale di sincronizzazione generato sulla base del BAUD RATE
	wire baud_clk;

	//FSM-->registro busy (anti glitch)
	wire busy_int;

	//input register: registro di campionamento dato da trasmettere
	assign en_in = (transmit==1'b1 && busy==1'b0) ? 1'b1: 1'b0; 
	register #(.N(DATA_BW)) DATA_IN(.D(data), .load(en_in), .clk(clk), .rst(rst), .Q(data_stored)); 

	//input register: registro di campionamento richiesta da parte del produttore
	/*questo registro interno viene SETTATO quando viene effettuata una richiesta da parte del produttore 
	RESETTATO (oltre che sul reset) quando la richiesta viene servita e si inizia la trasmissione dei dati su TX*/
	reg transmit_int;
	always@(posedge clk, posedge rst)
		if(rst==1'b1) transmit_int<=1'b0;
		else if(transmit==1'b1) transmit_int<=1'b1;
			else if(en=='b1) transmit_int<=1'b0;
		
	//clock generator: baud rate compliant
	//baud rate 9600bps, system clk 100MHz --> baud rate counter MAX=10416, N_BIT=14
	baud_rate_clk_gen #(.BAUD_CNT(BAUD_COUNT), .BAUD_BIT(BAUD_BIT)) BR_GEN(.clk(clk), .rst(rst), .baud_clk(baud_clk));

	//contatore dei dati trasmessi in uscita su TX
	counter #(.MAX(DATA_BW), .N_BIT(DATA_BW_BIT)) CNT_DATA(.clk(baud_clk), .rst(rst), .en(en), .count(count));
	assign hit = (count==DATA_BW-1) ? 1'b1: 1'b0; 
	 
	//macchina a stati di controllo della funzionalit� del sistema
	fsm_t #(.DATA_BW(DATA_BW), .DATA_BW_BIT(DATA_BW_BIT)) FSM_TX(.clk(baud_clk), .rst(rst), .transmit(transmit_int),
			.data_hit(hit), .data_in(data_stored), .count(count), .en(en), .TX(TX), .busy(busy_int));
		
	/*registro di output: questo registro per il busy verso l'uscita serve ad evitare che eventuali glitch sul busy inneschino 
	richieste di trasmissione da parte del produttore*/  
	always@(posedge clk, posedge rst)
		if(rst==1'b1) busy<=1'b0;
		else busy<=busy_int;

endmodule
