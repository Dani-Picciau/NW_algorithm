`include "/c:.../Output_manager.v"

module TB_Output_manager;

   // Signal inputs
    reg clk, rst;
    reg en_read;
    reg signal; 
    reg [1:0] count;
    reg [8:0] ram_data;

    // Signal outputs
    wire [8:0] diag, left, up;

    //Instantiation of the Output_manager module
    Output_manager test (
        .clk(clk), 
        .rst(rst), 
        .en_read(en_read), 
        .ram_data(ram_data), 
        .signal(signal),
        .diag(diag), 
        .left(left),    
        .up(up), 
        .count(count)
    );

    // Clock generation
    always #0.5 clk = ~clk;
    initial begin

        // Initializzation of signals
        clk = 0; rst = 1; en_read = 0; ram_data = 0;signal=0;count=0;

        // Sending signals ram_data
        #5.5  rst = 0; en_read = 1; 
            count = 0;
            ram_data = 9;
        #6  count = 1;
            ram_data = 8;
        #6  count = 2;
            ram_data = 7;
        #5  signal = 1;
        #1  signal=0;
            

            count = 0;
            ram_data = 6;
        #6  count = 1;
            ram_data = 5; 
        #6  count = 2;
            ram_data = 4;
        #5  signal = 1;
        #1  signal=0;

            count = 0;
            ram_data = 3;
        #6  count = 1;
            ram_data = 2;
        #6  count = 2;
            ram_data = 1; 
        #5  signal = 1;
        #1  signal=0;

        #4 $stop;
    end
endmodule
       
