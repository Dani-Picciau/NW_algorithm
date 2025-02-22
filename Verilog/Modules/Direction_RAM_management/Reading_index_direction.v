module Reading_index_direction #(
    parameter N=128,
    parameter BitAddr = $clog2(N+1),
    parameter addr_lenght = $clog2(((N+1)*(N+1)))
) (
    input wire clk, rst,
    input wire en_traceB,
    input wire [BitAddr:0] i_t, j_t,
    output reg [addr_lenght-1:0] addr_r
);
    reg [addr_lenght-1:0] addr_next;
    
    // Register for the addres
    always @(posedge clk, posedge rst) begin
        if(rst) addr_r <= 0;
        else addr_r <= addr_next;
    end

    always @(en_traceB, i_t, j_t, addr_r) begin
        if (en_traceB) addr_next = ( (j_t) + ((N+1) * (i_t)) );
        else addr_next = addr_r;
    end

    //end
endmodule