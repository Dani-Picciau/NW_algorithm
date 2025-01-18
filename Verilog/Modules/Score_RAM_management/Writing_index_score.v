module Writing_index_score #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_ins, en_init, hit,
    input wire [BitAddr:0] i, j, addr_init,
    input wire [8:0] max, data_init,
    output reg [addr_lenght:0] addr_out,
    output reg [8:0] data_out
);
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            addr_out <= 0;
            data_out <= 0;
        end
        else if(en_init) begin
                if(!hit) addr_out <= addr_init ;
                else addr_out<=addr_init*(N+1);
            data_out <= data_init;
        end
        else if(en_ins) begin
            addr_out <= ((j+1)+((N+1)*(i+1)));
            data_out <= max;
        end
        else begin
            addr_out <= 0;
            data_out <= 0;
        end
    end
endmodule