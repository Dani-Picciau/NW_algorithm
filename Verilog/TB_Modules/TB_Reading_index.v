`include "/c:.../Reading_index.v"

module TB_Reading_index;

    //Parameters
    parameter N = 128;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);

    //Signal input 
    reg clk, rst, en_read;
    reg [1:0] signal;
    reg [BitAddr:0] i, j;

    //Signal output
    wire [addr_lenght:0] addr;

    //Instantiation of the Reading_index module
    Reading_index #(
        .N(N),
        .BitAddr(BitAddr),
        .addr_lenght(addr_lenght)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .signal(signal),
        .i(i),
        .j(j),
        .addr(addr)
    );

    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        // Initialization of signals
        clk=0; rst=1; en_read=0;
    
        // Abilitation en_read
        #5 rst=0; en_read=1;

        // Test 1
           i=1; j=1; 
           signal=2'b00; // Expected value: 130
        #2 signal=2'b01; // Expected value: 131
        #2 signal=2'b10; // Expected value: 259

        // Test 2
        #5 i=0; j=1; 
           signal=2'b00; // Expected value: 1
        #2 signal=2'b01; // Expected value: 2
        #2 signal=2'b10; // Expected value: 130

        // Test 3
        #5 i=0; j=0; 
           signal=2'b00; // Expected value: 0
        #2 signal=2'b01; // Expected value: 1
        #2 signal=2'b10; // Expected value: 129
        #20;
        $stop;
    end
endmodule