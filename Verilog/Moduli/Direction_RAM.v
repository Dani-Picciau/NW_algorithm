module Direction_RAM #(
    parameter N=128, 
    parameter BitAddr = $clog2(N)
) (
    input wire clk,rst,
    input wire en_ins, we, en_traceB, en_init,
    input wire [BitAddr:0] i_in, j_in, i_t, j_t, addr,
    input wire [2:0] symbol_in,
    output reg [2:0] symbol_out, simbolo
);
    
    reg [2:0] ram [(N*N):0]; /* the ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings then each cell needs to be of 3 bits because we need them for the arrow < > \*/
    
    parameter UP=3'b010, LEFT=3'b100;

    wire [BitAddr:0] i,j; 
    
    always @(posedge clk, posedge rst, en_init, en_ins, we) begin
        if(rst) begin
            symbol_out<=0;
        end
        else if (en_init && we) begin
            /* initializzation for all the arrows, in the first column and in the first row, that points to the 0*/
            ram[addr] <= LEFT;
            ram[N*addr] <= UP; 
        end
        else if(en_ins && we) begin
            simbolo <= symbol_in;
            ram[(i+1)+(N*(j+1))] <= symbol_in;
        end
        else if(en_traceB) symbol_out <= ram[i_t+(N * j_t)];
    end
endmodule