//queste sono solo ram di appoggio per provare le sequenze, infatti sono riempire tramite initial

module RAM_B #(
    parameter N=5, // è a 5 solo per provare visto che non ho voglia di inserire 128 valori a mano
    parameter Bit = $clog2(N)
) (
    input wire clk, rst,
    input wire [8:0] din, // data in, to be written
    input wire en_din, 
    input wire en_dout, //en_read || en_trace_B
    input wire we, 
    input wire [Bit-1:0] addr_din, addr_dout,
    output reg [8:0] dout //data out, to be read
);
    reg [7:0] ram [N-1:0]; //128 cells, from 127 to 0. Every cell is 8 bits, from 7 to 0, for the ascii

    initial 
    begin
        ram[0]=8'h43; // C
        ram[1]=8'h54; // T
        ram[2]=8'h47; // G
        ram[3]=8'h41; // A
        ram[4]=8'h54; // T
    end

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