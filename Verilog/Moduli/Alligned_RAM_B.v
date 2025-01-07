module All_RAM_B #(
    parameter N=128, 
    parameter BitAddr = $clog2(N)
) (
    input wire clk,
    input wire en_traceB,
    input wire [BitAddr:0] j,
    input wire [2:0] data_in,
    output wire [2:0] data_out

);

    reg [BitAddr:0] addr_r;
    reg [8:0] ram [N-1:0];

    always @(posedge clk) begin
        if (en_traceB == 1'b1) begin
            ram[j] <= data_in;
        end
        addr_r <= j; 
     end

     assign data_out = ram[addr_r];

endmodule   