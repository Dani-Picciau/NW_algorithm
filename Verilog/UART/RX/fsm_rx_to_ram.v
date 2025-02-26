`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2025 11:52:00
// Design Name: 
// Module Name: fsm
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


module fsm(
    input wire clk, rst,
    input wire notvalid, fifo_empty, btn,
    output reg weA, weB, en, en_btn
);
    
    parameter IDLE=2'b00, WRITE_A=2'b01, WAIT_CHAR=2'b10, WRITE_B=2'b11; 
    reg [1:0] state, state_next; 
    
    always@(posedge clk, posedge rst)
        if(rst == 1'b1) state <= IDLE;
        else state <= state_next; 
        
    always @(state, notvalid, fifo_empty, btn) begin 
        case(state) 
        
        IDLE : begin 
            if(btn == 1'b1) state_next = WRITE_A; 
            else state_next = IDLE;  
        end
            
        WRITE_A: begin 
            if(notvalid == 1'b1) begin
                state_next = WAIT_CHAR;
            end
            else state_next = WRITE_A; 
        end 
            
        WAIT_CHAR: begin 
            if(notvalid == 1'b0) state_next = WRITE_B; 
            else state_next = WAIT_CHAR; 
        end
        
        WRITE_B: begin 
            if(fifo_empty == 1'b1) state_next = IDLE; 
            else state_next = WRITE_B;
        end 
        
        default: state_next = IDLE; 
        endcase 
    end
    
    // Output logic - ibrida (parte combinatoria e parte sequenziale)
    always @(state, notvalid) begin
        // Valori di default (prevenire latch)
        en = 1'b0;
        weB = 1'b0;
        en_btn = 1'b0; 
        
        // Gestione speciale per weA (risposta immediata a notvalid quando in WRITE_A)
        if(state == WRITE_A && notvalid == 1'b1)
            weA = 1'b0; // Abbassa weA immediatamente quando notvalid diventa 1 in WRITE_A
        else if(state == WRITE_A)
            weA = 1'b1; // Altrimenti mantieni weA alto in WRITE_A
        else
            weA = 1'b0; // weA basso in tutti gli altri stati
        
        // Logica per gli altri output basata sullo stato
        case(state) 
            IDLE: begin 
                en = 1'b0;
                // weA già gestito sopra
                weB = 1'b0;
                en_btn = 1'b0;
            end
            
            WRITE_A: begin 
                en = 1'b1;
                // weA già gestito sopra
                weB = 1'b0;
                en_btn = 1'b1;
            end
            
            WAIT_CHAR: begin 
                en = 1'b0;
                // weA già gestito sopra
                weB = 1'b0;
                en_btn = 1'b1;
            end
            
            WRITE_B: begin 
                en = 1'b1;
                // weA già gestito sopra
                weB = 1'b1;
                en_btn = 1'b1;
            end
        endcase
    end
endmodule
