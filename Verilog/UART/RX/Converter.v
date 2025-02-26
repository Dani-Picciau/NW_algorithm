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
     // Registra il dato di fifo_data_out quando btn è attivo
    reg [N-1:0] fifo_data_reg;
    reg btn_prev;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fifo_data_reg <= 0;
            btn_prev <= 0;
            char <= 3'b000;
        end
        else begin
            btn_prev <= btn;
            
            // Cattura il dato solo sul fronte di salita di btn
            if (btn && !btn_prev) begin
                fifo_data_reg <= fifo_data_out;
                
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
//    reg[2:0] char_nxt, char_nxt2;
    
//    always @(posedge clk, posedge rst) begin 
//        if(rst)begin  
//            char <= 3'b000;
//        end
//        else char<=char_nxt; 
//        end
        
//        always @(posedge clk, posedge rst) begin 
//            if(rst)begin  
//                char_nxt <= 3'b000;
//            end
//            else char_nxt<=char_nxt2; 
//        end
	
//	always @(fifo_data_out, posedge btn) begin
//	   if (btn)
//          case (fifo_data_out)
//                8'h47: char_nxt2 = 3'b001; //G
//                8'h43: char_nxt2 = 3'b110; //C
//                8'h41: char_nxt2 = 3'b100; //A
//                8'h54: char_nxt2 = 3'b011;  //T
//                default: char_nxt2 = 3'b000;
//		    endcase
//		else char_nxt2 = char_nxt;     
//        end
    
endmodule