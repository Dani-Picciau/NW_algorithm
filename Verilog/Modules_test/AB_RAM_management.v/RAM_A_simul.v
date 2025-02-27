//queste sono solo ram di appoggio per provare le sequenze, infatti sono riempite tramite initial

module RAM_A #(
    parameter N=5, // è a 5 solo per provare visto che non ho voglia di inserire 128 valori a mano
    parameter Bit = $clog2(N+1),
    parameter G=3'b001, 
    parameter C=3'b110, 
    parameter A=3'b100, 
    parameter T=3'b011
) (
    input wire clk, rst,
    // input wire [8:0] din, // data in, to be written
    // input wire en_din, 
    input wire en_dout, //en_read || en_trace_B
    // input wire we, 
    input wire [Bit:0] /*addr_din,*/ addr_dout,
    output reg [2:0] dout //data out, to be read
);
    reg [2:0] ram [N-1:0]; //128 cells, from 127 to 0. Every cell is 3 bits, from 2 to 0, for our convertion
    
    initial begin
        ram[0]=C;
        ram[1]=A;
        ram[2]=C;
        ram[3]=T;
        ram[4]=G;
    end

    // always @(posedge clk) begin
    //     if(en_din)begin
    //         if(we) ram[addr_din] <= din;
    //     end
    // end

    always @(posedge clk, posedge rst) begin
        if(rst) dout <= 0;
        else if(en_dout) dout <= ram[addr_dout];
    end
endmodule