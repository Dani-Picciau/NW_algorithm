`timescale 1ns / 1ps

        
//module gest_add #(
//    parameter N=8,
//    ADDR= $clog2(N+1)
    
//)(
//    input wire clk, rst,
//    input wire weA, weB,btn,
//    input wire [N-1:0] fifo_out,
//    output reg [ADDR-1:0] addr_rA, addr_rB
//);

//    reg addr_rA_next, addr_rB_next;
    
//    // Blocco sequenziale per aggiornare gli indirizzi
//    always @ (posedge clk , posedge rst) begin 
//        if(rst) begin 
//            addr_rA <= 0;  // Reset a zero
//            addr_rB <= 0;  // Reset a zero
//        end    
//        else begin
//            addr_rA <= addr_rA_next;  // Reset a zero
//            addr_rB <= addr_rB_next;  // Reset a zero
//        end
//    end
    
//    always @(fifo_out,weA) begin
//        if(weA) addr_rA_next <= addr_rA + 1;
//        else addr_rA_next <= addr_rA;
//    end
    
    
//    always @(posedge clk) begin
//        if(weB) addr_rB <= addr_rB + 1;
//        else addr_rB_next <= addr_rB;
//    end
    
//endmodule
module gest_add #(
    parameter N=8,
    ADDR= $clog2(N+1)
)(
    input wire clk, rst,
    input wire weA, weB,
    input wire [2:0] Seq,
    output reg [ADDR-1:0] addr_rA, addr_rB
);
    reg [ADDR-1:0] addr_rA_next, addr_rB_next;
    
    // Blocco sequenziale per aggiornare gli indirizzi
    always @ (posedge clk or posedge rst) begin 
        if (rst) begin 
            addr_rA <= 0;  
            addr_rB <= 0;  
        end else begin
            addr_rA <= addr_rA_next;  
            addr_rB <= addr_rB_next;  
        end
    end
    
    always @(Seq) begin
        if (Seq && weA) 
            addr_rA_next = addr_rA + 1;
        else 
            addr_rA_next = addr_rA;
    end

    always @(Seq,weB) begin
        if ( Seq && weB) 
            addr_rB_next = addr_rB + 1;
        else 
            addr_rB_next = addr_rB;
    end
endmodule
