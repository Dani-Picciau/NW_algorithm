module Reading_index_score #(
    parameter N = 128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1)
) (
    input wire clk, rst,
    input wire en_read,
    input wire [1:0] count,
    input wire [BitAddr:0] i, j,
    input wire change_index,
    output reg [addr_lenght:0] addr
);
    
    reg [addr_lenght:0] addr_next;
    
    // Register for the addres
    always @(posedge clk, posedge rst) begin
        if(rst) addr <= 0;
        else addr <= addr_next;
    end
    
    always @(en_read, change_index, count, i, j) begin
        if (en_read && !change_index) begin
            case (count)
                2'b00: addr_next = (j+(N+1)*i);
                2'b01: addr_next = ((j+1)+(N+1)*i);
                2'b10: addr_next = (j+(N+1)*(i+1));
                default: addr_next = addr;
            endcase
        end
        else begin
            addr_next = addr;
        end
    end
endmodule