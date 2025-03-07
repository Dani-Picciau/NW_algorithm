//queste sono solo ram di appoggio per provare le sequenze, infatti sono riempite tramite initial

module RAM_A #(
    parameter N=8, // � a 5 solo per provare visto che non ho voglia di inserire 128 valori a mano
    parameter Bit = $clog2(N+1)
) (
    input wire clk, rst,
     input wire [2:0] din, // data in, to be written, da tre bit perche modificato da converter 
     input wire en_din, 
    input wire en_dout, //en_read || en_trace_B
     input wire we, 
    input wire [Bit:0] addr_din, addr_dout,
    output reg [2:0] dout //data out, to be read
);
    reg [2:0] ram [N-1:0]; //128 cells, from 127 to 0. Every cell is 3 bits, from 2 to 0, for our convertion

    //parameter G=3'b001, C=3'b110, A=3'b100, T=3'b011; 
    
    
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

//queste sono solo ram di appoggio per provare le sequenze, infatti sono riempite tramite initial

module RAM_B #(
    parameter N=7, // � a 5 solo per provare visto che non ho voglia di inserire 128 valori a mano
    parameter Bit = $clog2(N+1)
) (
    input wire clk, rst,
    input wire [2:0] din, // data in, to be written da tre bit perche modificato da converter
    input wire en_din, 
    input wire en_dout, //en_read || en_trace_B
    input wire we,
    input wire [Bit:0] addr_din,addr_dout,
    output reg [2:0] dout //data out, to be read
);
    reg [2:0] ram [N-1:0]; //128 cells, from 127 to 0. Every cell is 3 bits, from 2 to 0, for our convertion

    //parameter G=3'b001, C=3'b110, A=3'b100, T=3'b011; 

   

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