module Al_RAM_B #(
    parameter N=128, 
    parameter BitAddr = $clog2(N*N+1)
) (
    input wire clk,
    input wire en_traceB,
    input wire [BitAddr:0] j,
    input wire [2:0] data_in,
    output wire [2:0] data_out
);
    reg [BitAddr:0] addr_r;
    reg [8:0] ram [(N*N)-1:0];

    always @(posedge clk) begin
        if (en_traceB == 1'b1) ram[j] <= data_in;
        addr_r <= j; 
    end

    assign data_out = ram[addr_r];
endmodule   