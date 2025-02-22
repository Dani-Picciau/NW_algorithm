`include "/c:.../Initialization_counter.v"

module TB_Initialization_counter;
    integer index;
    parameter N = 5;
    parameter BitAddr = $clog2(N+1);

    reg clk, rst;
    reg en_init;
    reg hit;
    wire [BitAddr:0] addr;
    wire signed [8:0] data;
    wire end_init;
    
    Initialization_counter #(
        .N(N)
    ) Init_c (
        .clk(clk),
        .rst(rst),
        .en_init(en_init),
        .hit(hit),
        .addr(addr),
        .data(data),
        .end_init(end_init)
    );

    // Generate the clock signal
    always #0.5 clk = ~clk;

    initial begin
        index=0;
        clk=0;
        rst=1;
        en_init=0;
        hit=0;
        
        #5.5 rst=0;
        en_init=1;
        for(index = 0; index < 6; index = index + 1) begin
            #2 hit = 1;
            #2 hit = 0;
        end
        #5
        $stop;
    end
endmodule