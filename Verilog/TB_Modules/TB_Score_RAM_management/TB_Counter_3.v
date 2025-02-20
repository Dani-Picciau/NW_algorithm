`include "/c:.../Counter_3.v"

module TB_Counter_3;

    // Signal inputs
    reg clk, rst;
    reg en;

    // Signal outputs
    wire signal;
    wire [1:0] count;

    // Instantiation of the Counter_3 module
    Counter_3 test (
        .clk(clk),
        .rst(rst),
        .en(en),
        .signal(signal),
        .count(count)
    );

    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        // Initialization of signals
        clk=0; rst=1; en=0;

        // Start counting
        #5 rst=0; en=1;
        #15
        $stop;
    end
endmodule
