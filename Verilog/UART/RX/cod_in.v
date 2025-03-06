`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2025 11:17:59
// Design Name: 
// Module Name: Converter
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


module cod_in #(
    parameter N=8
)(
	input wire clk,rst,btn,
	input wire [N-1:0] fifo_data_out, //data out from the UART
	output reg [2:0] char //data codified for our system
);
     // Registra il dato di fifo_data_out quando btn � attivo
    
    reg btn_prev;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            btn_prev <= 0;
            char <= 3'b000;
        end
        else begin
            btn_prev <= btn;
            
            // Cattura il dato solo sul fronte di salita di btn
            if (btn && !btn_prev) begin
                // Converti immediatamente
                case (fifo_data_out)
                    8'h47: char <= 3'b001; // G
                    8'h43: char <= 3'b110; // C
                    8'h41: char <= 3'b100; // A
                    8'h54: char <= 3'b011; // T
                    8'h23: char <= 3'b010; // # 'dato non valido' 
                    default: char <= 3'b000;
                endcase
            end
        end
    end

endmodule