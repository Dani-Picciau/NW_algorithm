`include "/c:.../Counter_1.v"

module TB_Counter_1;

    // Signal inputs
    reg clk, rst;
    reg en_init;

    // Signal outpus
    wire hit;

    // Instantiation of the Counter_1 module
    Counter_1 test (
        .clk(clk),
        .rst(rst),
        .en_init(en_init),
        .hit(hit)
    );

    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        // Initializzation of signals
        clk = 0; rst = 1; en_init = 0;

        // Start counting
        #5 rst = 0;
        #5 en_init = 1;
        
        #10
        $stop;
    end
endmodule