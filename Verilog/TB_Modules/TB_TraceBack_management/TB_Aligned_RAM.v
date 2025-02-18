`include "/c:.../Al_RAM.v"

module test_Alligned_RAM_A;

    // Parameters
    parameter N = 128;
    parameter BitAddr = $clog2(N);

    // Inputs
    reg clk;
    reg en_traceB;
    reg [BitAddr:0] i;
    reg [2:0] data_in;

    // Outputs
    wire [2:0] data_out;

    // Instantiate the Unit Under Test (test)
    All_RAM_A #(
        .N(N), 
        .BitAddr(BitAddr)
    ) test (
        .clk(clk),
        .en_traceB(en_traceB),
        .i(i),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        en_traceB = 0;
        i = 0;
        data_in = 0;

        // Wait for global reset
        #10;

        // Test 1: Write and read from address 0
        en_traceB = 1;
        i = 0;
        data_in = 3'b101;
        #10;
        en_traceB = 0;
        #10;
        if (data_out !== 3'b101) $display("Test 1 failed");

        // Test 2: Write and read from address 1
        en_traceB = 1;
        i = 1;
        data_in = 3'b110;
        #10;
        en_traceB = 0;
        #10;
        if (data_out !== 3'b110) $display("Test 2 failed");

        // Test 3: Write and read from address 2
        en_traceB = 1;
        i = 2;
        data_in = 3'b011;
        #10;
        en_traceB = 0;
        #10;
        if (data_out !== 3'b011) $display("Test 3 failed");

        // Test 4: Read from address 0 again
        i = 0;
        #10;
        if (data_out !== 3'b101) $display("Test 4 failed");

        // Test 5: Read from address 1 again
        i = 1;
        #10;
        if (data_out !== 3'b110) $display("Test 5 failed");

        // Test 6: Read from address 2 again
        i = 2;
        #10;
        if (data_out !== 3'b011) $display("Test 6 failed");

        $display("All tests completed");
        $stop;
    end
endmodule