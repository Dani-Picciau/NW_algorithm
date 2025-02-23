`include "/c:.../Counter_Aligned.v"

module test_Counter_Aligned;

    // Parameters
    parameter MAX = 32;

    // Inputs
    reg clk;
    reg rst;
    reg en_traceB;

    // Outputs
    wire [$clog2(MAX):0] address;

    // Instantiate the Unit Under Test (test)
    Counter_Alligned #(
        .MAX(MAX)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .address(address)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        en_traceB = 0;

        // Reset the counter
        rst = 1;
        #10;
        rst = 0;
        #10;

        // Enable tracing
        en_traceB = 1;
        #1000;

        // Disable tracing
        en_traceB = 0;
        #10;
        $stop;
    end
endmodule