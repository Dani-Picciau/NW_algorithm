module Direction_RAM #(
    parameter N=128, 
    parameter addr_lenght = $clog2(((N+1)*(N+1)))
) (
    input wire clk, rst,
    input wire [2:0] din, // data in, to be written
    input wire en_din, //en_din (en_write) is an OR between en_ins and en_init
    input wire en_dout, //en_traceBack
    input wire we, 
    input wire [addr_lenght-1:0] addr_din, addr_dout,
    output reg [2:0] dout //data out, to be read
);
    reg [2:0] ram [((N+1)*(N+1))-1:0];

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
