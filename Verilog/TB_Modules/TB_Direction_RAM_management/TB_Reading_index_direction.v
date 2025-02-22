`include "/c:.../Reading_index_direction.v"

module TB;
  //Parameters
    parameter N = 5;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1)));

    //Signal input 
    reg clk, rst, en_traceB;
    reg [BitAddr:0] i_t, j_t;

    //Signal output
    wire [addr_lenght-1:0] addr_r;

    //Instantiation of the Reading_index module
    Reading_index_direction #(
        .N(N),
        .BitAddr(BitAddr),
        .addr_lenght(addr_lenght)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .i_t(i_t),
        .j_t(j_t),
        .addr_r(addr_r)
    );

    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        // Initialization of signals
        clk=0; rst=1; en_traceB=0; i_t=0; j_t=0;
    
        // Abilitation en_read
        #5.5 rst=0; en_traceB=1;
            i_t=0; j_t=0;
        #5  i_t=0; j_t=1;
        #5 en_traceB=0;i_t=1; j_t=0;
        #5 en_traceB=1;


        #5;
        $stop;
    end
endmodule
