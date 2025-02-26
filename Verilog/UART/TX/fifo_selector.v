`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2025 10:21:05
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


module selector_fifo  #(
    parameter
    DATA_BITS=8
    )(
        input wire clk, rst,
        input wire tx_done,
        input wire [DATA_BITS-1:0] data_A, data_B,
        input wire not_emptyA, not_emptyB, // sono a 1 se nella fifo c'è almeno un elemento
        input wire hit, //è emptyA, quindi !not_emptyA, ma arriva un colpo di clk dopo , sceglie da quale fifo leggere. 
        output reg [DATA_BITS-1:0] data,
        output reg not_empty, readA, readB
    );

    
    always @ (posedge clk, posedge rst)
    if(rst) begin
        data <= 0;
        not_empty <= 0;
        readA<=0;
        readB<=0;
    end
    else if(hit==1'b0) begin
        data <= data_A;
        not_empty <= not_emptyA;
        readA <= tx_done;
        readB <= 1'b0;
    end
    else begin  // la fifo A è vuota, quindi leggo la B 
        data <= data_B;
        not_empty <= not_emptyB; 
        readA <= 1'b0;
        readB <= tx_done;
    end
   
endmodule