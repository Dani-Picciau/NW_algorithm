`include "/c:/Users/dany2/OneDrive/Desktop/Documenti/GitHub/NW_algorithm/Verilog/Moduli/Max.v"

module TB_Max;
    reg clk, value;
    reg [8:0] diag, up, lx;
    wire [8:0] max;
    wire [2:0]symbol;
    wire calculated;
    
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
    
    always #0.5 clk=~clk;
    initial begin
        clk=0;
        value= 1;
        diag=-4;up=-2; lx=-3;   
        #20;
        $stop;
    end
endmodule



