`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2025 11:40:45
// Design Name: 
// Module Name: check
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


module check_data(
    input wire [2:0]data,
    input clk,rst,
    output reg not_valid
    );
        
    always@(data) begin 
        case (data)
            3'b010: not_valid = 1'b1; //# dato non valido
            3'b100: not_valid = 1'b0;  //A
            3'b110: not_valid = 1'b0;  //C
            3'b001: not_valid = 1'b0;  //G
            3'b011: not_valid = 1'b0;   //T
            
            default: not_valid = 1'b0; // All other values
        endcase
    end
                 
endmodule
