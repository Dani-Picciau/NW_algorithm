`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Uniss
// Engineer: Matteo Pedoni
// 
// Create Date: 03.01.2025 19:17:52
// Design Name: 
// Module Name: Insertion
// Project Name: Progetto finale ESD
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


module Insertion_Counter #(
    parameter N = 8
)(
    input wire clk, rst,
    input wire en_read,
    output wire end_filling,
    output wire [{$clog2(N)}:0] i, j
);
    reg [{$clog2(N)}:0 ] countJ, count_nxtJ; 
    reg [{$clog2(N)}:0 ] countI, count_nxtI;
    reg en_APP; 
    
    // aggiornamento registro di stato
    always @ (posedge clk, posedge rst)
        if(rst == 1'b1) begin 
             countI <= 1'b0;
             countJ <= 1'b0;
        end
        else begin
            countI <= count_nxtI;
            countJ <= count_nxtJ;
        end 

    // Logica di "somma" per l'indice J
      always @ ( posedge clk) begin
        if (en_read == 1'b1 && countJ <= N) begin
             count_nxtJ = countJ + 1;

             if (countJ == N) begin
                count_nxtJ = 1'b0; 
                en_APP = 1'b1; 
            end
            else en_APP = 1'b0;
        end     
        else count_nxtJ = countJ; 
    end

    //Logica di "somma" per l'indice I
    always@(posedge clk) begin
        if(en_APP == 1'b1 && countI <= N) begin
            if( countI == N) count_nxtI = 1'b0;
            else count_nxtI = countI + 1; 
        end 
        else count_nxtI = countI ; 
    end

   
    // assegnazione degli indici
    assign i = countI; 
    assign j = countJ; 

    // assegnazione segnale en_filling, se siamo arrivati al numero massimo di locazione, invio il segnale
    assign end_filling = (en_read == 1'b1 && i == N && j == N) ? 1'b1 : 1'b0; 

endmodule
