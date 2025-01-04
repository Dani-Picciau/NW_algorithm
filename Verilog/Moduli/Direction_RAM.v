module Direction_RAM #(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_ins, we, en_traceB, en_init,
    input wire [BitAddr:0] i, j, i_t, j_t, addr,
    input wire [2:0] symbol_in,
    output reg [2:0] symbol_out
);

    reg [2:0] ram [((N+1)*(N+1))-1:0]; /*the ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings then each cell needs to be of 3 bits because we need them for the arrow: <-, ⭡, ↖ */
    
    parameter UP=3'b010, LEFT=3'b100;
    
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            symbol_out<=0;
        end
        else if (en_init && we) begin
            /*Initializzation for all the arrows, in the first column and in the first row, that points to the 0*/
            ram[addr] <= LEFT;
            ram[(N+1)*addr] <= UP; 
        end
        else if(en_ins && we) ram[(i+1)+((N+1)*(j+1))] <= symbol_in;
        else if(en_traceB) symbol_out <= ram[i_t + (N+1) * j_t];
    end
endmodule