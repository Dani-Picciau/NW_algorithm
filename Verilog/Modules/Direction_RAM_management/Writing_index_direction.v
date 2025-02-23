module Writing_index_direction #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))),
    parameter UP = 3'b010, 
    parameter LEFT = 3'b100
) (
    input wire clk, rst,
    input wire en_ins, en_init, hit,
    input wire [BitAddr:0] i, j, addr_init,
    input wire [2:0] symbol,
    output reg [addr_lenght-1:0] addr_out,
    output reg [2:0] symbol_out
);

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            addr_out <= 0;
            symbol_out <= 0;
        end
        else if(en_init) begin
            if(!hit) begin
                addr_out <= addr_init ;
                symbol_out <= LEFT;
            end
            else begin
                addr_out<=addr_init*(N+1);
                symbol_out <= UP;
            end 

        end
        else if(en_ins) begin
            addr_out <= ( (j+1) + ((N+1)*(i+1)) );
            symbol_out <= symbol;
        end
        else begin
            addr_out <= 0;
            symbol_out <= 0;
        end
    end
endmodule