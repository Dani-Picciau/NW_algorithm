`include "/c:.../Max.v"

module TB_Max;

   // Input signals
    reg clk;
    reg value;
    reg [8:0] diag;
    reg [8:0] up;
    reg [8:0] lx;

    // Output signals
    wire [8:0] max;
    wire [2:0]symbol;
    wire calculated;
    
    // Instantiation of the Max module
    Max test(
        .clk(clk), 
        .value(value),
        .diag(diag), 
        .up(up), 
        .lx(lx),
        .max(max),
        .symbol(symbol),
        .calculated(calculated)
    );
    
    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        clk=0;
        value= 1;
        diag=-4;up=-2; lx=-3;   
        #20;
        $stop;
    end
endmodule



