module Scores_RAM #(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk, rst,
    input wire [8:0] din,
    input wire en_din, en_dout, we, //en_din is an OR between en_ins and en_init
    input wire [BitAddr:0] addr_din, addr_dout,
    output reg [8:0] dout
);
    reg [8:0] ram [((N+1)*(N+1))-1:0]; /*The ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings then each cell needs to be of 9 bits because that's how many bits are needed to store the numbers -128 to +128 in c2*/

    always @(posedge clk) begin
        if(en_din)begin
            if(we) ram[addr_din] <= din;
        end
    end

    always @(posedge clk, posedge rst) begin
        if(rst) dout <= 0;
        else if(en_dout) dout <= ram[addr_dout];
    end
endmodule