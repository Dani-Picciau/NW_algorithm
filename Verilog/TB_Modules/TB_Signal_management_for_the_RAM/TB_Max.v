`include "/c:.../Max"

module TB_Max;
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    
    reg clk, rst, value;
    reg signed [8:0] diag, up, lx;
    wire signed [8:0] max;
    wire [2:0] symbol;
    wire calculated;
    
    Max # (
        .gap_score(gap_score),
        .match_score(match_score),
        .mismatch_score(mismatch_score)
    ) maximum (
        .clk(clk),
        .rst(rst),
        .value(value),
        .diag(diag),
        .up(up),
        .lx(lx),
        .max(max),
        .symbol(symbol),
        .calculated(calculated)
    );
    
    // Generate the clock signal
    always #0.5 clk = ~clk; // Toggle the clock every 0.5ns
    
    initial begin
        clk=0;
        rst=1;
        value=0;
        diag=0;
        up=0;
        lx=0;
        
        #5.5 rst=0;
        
        //Mismatch C - G
        value=0;
        diag=0;
        up=-2;
        lx=-2;
        #5
        
        //Mismatch C - A
        value=0;
        diag=-2;
        up=-4;
        lx=-1;
        #5
        
        //Mismatch C - T
        value=0;
        diag=-4;
        up=-6;
        lx=-3;
        #5
        
        //Mismatch C - G
        value=0;
        diag=-6;
        up=-8;
        lx=-5;
        #5
        
        //Match C - C
        value=1;
        diag=-8;
        up=-10;
        lx=-7;
        #5
        
        $stop;
    end
endmodule