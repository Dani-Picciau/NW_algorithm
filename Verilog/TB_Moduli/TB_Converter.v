`include "/c:.../Converter.v"

module TB_Converter;

    // Input signals
    reg clk;
    reg rst;
    reg start;

    // Output signals
    wire [2:0] rom_data;
    wire done;

   // Instantiation of the Converter module
    Converter test (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rom_data(rom_data),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk; 
   
    initial begin
        // Initialization of signals
        clk = 0; rst = 1; start = 0;
        #10
        //Start reading
        rst=0; start=1;
        #150 // Insert the number of cycles needed to read the file
        $stop;
    end
endmodule