`include "C:\Users\Monica\Documents\GitHub\NW_algorithm\Verilog\Moduli\Scores_RAM.v"

module TB_Scores_RAM;

    // Parameters
    parameter N = 4;
    parameter BitAddr = $clog2(N+1);

    // Input signals
    reg clk;
    reg rst;
    reg en_init;
    reg en_ins;
    reg en_read;
    reg we;
    reg [BitAddr:0] addr;
    reg [BitAddr:0] i_in;
    reg [BitAddr:0] j_in;
    reg [8:0] max;
    reg [8:0] data;

    // Output signals
    wire [8:0] diag;
    wire [8:0] up;
    wire [8:0] left;

    // Instantiation of the Scores_RAM module
    Scores_RAM #(.N(N)) test (
        .clk(clk),
        .rst(rst),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_read(en_read),
        .we(we),
        .addr(addr),
        .i(i_in),
        .j(j_in),
        .max(max),
        .data(data),
        .diag(diag),
        .up(up),
        .left(left)
    );

    // Clock generation
    always #1 clk = ~clk;

    initial begin
        // Initialization of signals
        clk = 0;
        rst = 1;
        en_init = 0;
        en_ins = 0;
        en_read = 0;
        we = 0;
        addr = 0;
        i_in = 0;
        j_in = 0;
        max = 0;
        data = 0;

        // Reset
        #10;
        rst = 0;

        // Initialization test
        en_init = 1;
        we = 1;
        addr = 0;
        data = 9'b0;
        #8;
        addr = 1;
        data = 9'b111111111;
        #8;
        addr = 2;
        data = 9'b111111110;
        #8;
        addr = 3;
        data = 9'b111111101;
        #8;
        en_init = 0;
        we = 0;

        // Insertion and read test
        #8
        en_ins = 1;
        we = 1;
        
        // cell 1:1
        i_in = 0;
        j_in = 0;
        max = 9'b000000001;
        
        // cell 1:2
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 0;
        j_in = 1;
        max = 9'd12;
        
        // cell 1:3
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 0;
        j_in = 2;
        max = 9'd13;
        
        // cell 2:1
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 1;
        j_in = 0;
        max = 9'd21;
        
        // cell 2:2
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 1;
        j_in = 1;
        max = 9'd2;
        
        // cell 2:3
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 1;
        j_in = 2;
        max = 9'd23;
        
        // cell 3:1
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 2;
        j_in = 0;
        max = 9'd31;
        
        // cell 3:2
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 2;
        j_in = 1;
        max = 9'd32;
        
        // cell 3:3
        #4 we=0; #2 en_read=1;
        #4 we=1; #2 en_read=0;
        i_in = 2;
        j_in = 2;
        max = 9'd3;
        
        #4;
        we = 0; 
        #2 en_read=1;
        #4;
        en_ins = 0;

        // End of the test
        #10;
        $stop;
    end
endmodule