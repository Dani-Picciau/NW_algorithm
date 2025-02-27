`include "C:\..."

module Total_TOP #(
    parameter N = 3,
    parameter BitAddr = $clog2(N+1)
)(
    input wire clk, rst, 
    input wire rx,
    input wire ready,
    
    output wire signed [BitAddr:0] final_score, 
    output wire [2:0] datoA, datoB,
    output wire [6:0] seg, 
    output wire [3:0] an 
);

    wire [2:0] din_ram; // data to be written in the RAMs
    wire en_ram; 
    wire weA, weB;
    wire [BitAddr:0] addr_dinA, addr_dinB;
    
    
    uart_top #(
        .N(N)
    ) UART_RX (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .Seq(din_ram),
        .enable_ram(en_ram),
        .weA(weA),
        .weB(weB),
        .address_ramA(addr_dinA),
        .address_ramB(addr_dinB)
    );
    
    TopModule #(
        .N(N)
    ) NW (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB),
        .seg(seg),
        .an(an),
        .din_ram(din_ram),
        .en_ram(en_ram),
        .weA(weA),
        .weB(weB),
        .addr_dinA(addr_dinA),
        .addr_dinB(addr_dinB)
    );
    
endmodule