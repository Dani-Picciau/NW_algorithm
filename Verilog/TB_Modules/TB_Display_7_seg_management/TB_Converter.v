`include "/c:.../Converter.v"

module TB_Converter;
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
   
   reg [4:0] Tens;     // Tens digit
   reg [3:0] Units;    // Units digit
   wire [6:0] digit1;   // 7-segment display
   wire [6:0] digit2;   // 7-segment display
   
   Converter # (
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
   ) conv (
      .Tens(Tens),
      .Units(Units),
      .digit1(digit1),
      .digit2(digit2)
   );

initial begin
         Tens=4;
         Units=9;
      #5 Tens=5;
         Units=0;
      #5 Tens=0;
         Units=0;
      #5 Tens=10;
         Units=0;
      #5 Tens=25;
         Units=5;
      #5 Tens=7;
         Units=5;
      #5 Tens=0;
         Units=7;
      #5
      $stop;
   end
endmodule