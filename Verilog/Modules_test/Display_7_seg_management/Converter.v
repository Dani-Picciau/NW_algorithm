module Converter # (
    parameter OFF=7'b1111111,  //OFF
    parameter ZERO=7'b1000000, //0
    parameter ONE=7'b1111001,  //1
    parameter TWO=7'b0100100,  //2
    parameter THREE=7'b0110000,//3
    parameter FOUR=7'b0011001, //4
    parameter FIVE=7'b0010010, //5
    parameter SIX=7'b0000010,  //6
    parameter SEVEN=7'b1111000,//7
    parameter EIGHT=7'b0000000,//8
    parameter NINE=7'b0010000, //9
    parameter M=7'b1101010,    //M
    parameter A=7'b0001000,    //A 
    parameter DASH=7'b0111111  //-
) (
    input wire [4:0] Tens,     // Tens digit
    input wire [3:0] Units,    // Units digit
    output reg [6:0] digit1,   // 7-segment display
    output reg [6:0] digit2    // 7-segment display
);

    always @(Tens, Units) begin
        //If the last value of final_score isn't calculated yet
        if(Tens == 25 && Units == 5) begin
            digit1 = DASH;
            digit2 = DASH;
        end
        // Case MAX (100): Tens = 10 (1010 in binary) e Units = 0
        else if (Tens == 4'b1010 && Units == 4'b0000) begin
            digit1 = M;
            digit2 = A;
        end
        // Number from 0 to 9
        else if (Tens == 4'b0000) begin
            digit1 = OFF;
            case(Units)
                4'b0000: digit2 = ZERO;
                4'b0001: digit2 = ONE;
                4'b0010: digit2 = TWO;
                4'b0011: digit2 = THREE;
                4'b0100: digit2 = FOUR;
                4'b0101: digit2 = FIVE;
                4'b0110: digit2 = SIX;
                4'b0111: digit2 = SEVEN;
                4'b1000: digit2 = EIGHT;
                4'b1001: digit2 = NINE;
                default: digit2 = OFF;
            endcase
        end
        // All the other case (number from 10 to 99)
        else begin
            case(Tens)
                4'b0001: digit1 = ONE;
                4'b0010: digit1 = TWO;
                4'b0011: digit1 = THREE;
                4'b0100: digit1 = FOUR;
                4'b0101: digit1 = FIVE;
                4'b0110: digit1 = SIX;
                4'b0111: digit1 = SEVEN;
                4'b1000: digit1 = EIGHT;
                4'b1001: digit1 = NINE;
                default: digit1 = OFF;
            endcase
            
            case(Units)
                4'b0000: digit2 = ZERO;
                4'b0001: digit2 = ONE;
                4'b0010: digit2 = TWO;
                4'b0011: digit2 = THREE;
                4'b0100: digit2 = FOUR;
                4'b0101: digit2 = FIVE;
                4'b0110: digit2 = SIX;
                4'b0111: digit2 = SEVEN;
                4'b1000: digit2 = EIGHT;
                4'b1001: digit2 = NINE;
                default: digit2 = OFF;
            endcase
        end
    end
endmodule