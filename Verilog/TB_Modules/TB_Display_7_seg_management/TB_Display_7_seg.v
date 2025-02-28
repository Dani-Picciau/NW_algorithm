`include "/c:.../Display_7_seg.v"

module TB_Display_7_seg;
    parameter OFF=7'b1111111;  //OFF
    parameter ZERO=7'b1000000; //0
    parameter ONE=7'b1111001;  //1
    parameter TWO=7'b0100100;  //2
    parameter THREE=7'b0110000;//3
    parameter FOUR=7'b0011001; //4
    parameter FIVE=7'b0010010; //5
    parameter SIX=7'b0000010;  //6
    parameter SEVEN=7'b1111000;//7
    parameter EIGHT=7'b0000000;//8
    parameter NINE=7'b0010000; //9
    parameter M=7'b1101010;    //M
    parameter A=7'b0001000;    //A
    parameter X=7'b0001001;    //X   
    parameter PERC1=7'b0100011; //% 
    parameter PERC2=7'b0011100; //%
    parameter DASH=7'b0111111; //-
    
    reg clk, rst; 
    reg [6:0] digit1, digit2;
    wire [6:0] seg;
    wire [3:0] an;
    
    Display_7_seg # (
        .OFF(OFF),
        .ZERO(ZERO),
        .ONE(ONE),
        .TWO(TWO),
        .THREE(THREE),
        .FOUR(FOUR),
        .FIVE(FIVE),
        .SIX(SIX),
        .SEVEN(SEVEN),
        .EIGHT(EIGHT),
        .NINE(NINE),
        .M(M),
        .A(A),
        .X(X),
        .PERC1(PERC1),
        .PERC2(PERC2),
        .DASH(DASH)
    ) display(
        .clk(clk),
        .rst(rst),
        .digit1(digit1),
        .digit2(digit2),
        .seg(seg),
        .an(an)
    );
   
   always #0.5 clk = ~clk;

   initial begin //Remember to change digit_timer equal to 4
        clk=0;
        rst=1;
        digit1 = DASH;
        digit2 = DASH;
        
        #5.5 rst=0;
        
        //case1: the score is not valid
        digit1 = DASH;
        digit2 = DASH;
        
        #19
        
        //The score is MAX
        digit1 = M;
        digit2 = A;
        
        #20
        
        //Every other case, for example (55)
        digit1 = FIVE;
        digit2 = FIVE;
        
        #18
        $stop;
    end
endmodule