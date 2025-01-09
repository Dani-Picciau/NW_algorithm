module Reading_index_score #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_read,
    input wire [1:0] signal,
    input wire [BitAddr:0] i, j,
    output reg [addr_lenght:0] addr
);
    always @(posedge clk, posedge rst) begin
        case ({en_read, signal})
            3'b100: addr <= (j+(N+1)*i); // Index for the diagonal
            3'b101: addr <= ((j+1)+(N+1)*i); // Index for the  left
            3'b110: addr <= (j+(N+1)*(i+1)); // Index for the up
            default: addr <= {addr_lenght{1'bx}};
        endcase
    end
endmodule