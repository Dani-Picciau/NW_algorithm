module Reading_index_score #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_read,
    input wire [1:0] count,
    input wire [BitAddr:0] i, j,
    output reg [addr_lenght:0] addr
);
    
    always @(posedge clk, posedge rst) begin
        case ({en_read, count})
            3'b100: begin
                addr <= (j+(N+1)*i); // Index for the diagonal
         
            end 
            3'b101: begin
                addr <= ((j+1)+(N+1)*i); // Index for the up
           
            end
            3'b110: begin
                addr <= (j+(N+1)*(i+1)); // Index for the left
               
            end 
            default: begin
                addr <= {addr_lenght{1'bx}};
        
            end
        endcase
    end
endmodule
