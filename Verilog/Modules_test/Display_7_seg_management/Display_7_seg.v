module Display_7_seg #(
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
    parameter X=7'b0001001,    //X   
    parameter PERC1=7'b0100011, //% 
    parameter PERC2=7'b0011100, //%
    parameter DASH=7'b0111111, //-
    parameter N = 5
)(
    input wire clk, // Basys3 clock (100MHz)
    input wire rst,
    input wire [6:0] digit1, // 7-segment display
    input wire [6:0] digit2, // 7-segment display
    output reg [6:0] seg, // Cathodes for each anode
    output reg [3:0] an //  Anodes for each digit
);
    //To select each digit in turn
    reg [1:0] digit_select; //2 bit counter for selecting each of 4 digits
    reg [16:0] digit_timer; //Counter for digit refresh
    
    //Logic for controlling digit select and digit timer
    /* We want 1ms of refresh rate for each display digit:
       1ms = (1/1000) x 4 display = 4ms
       Our basys3 clock have 100Mhz so --> 100MHz/100,000 = 1000 : each display for 1ms
    */
    always @(posedge clk, posedge rst)begin
        if(rst) begin
            digit_select <= 0;
            digit_timer <= 0;
        end
        else begin
            if(digit_timer == 99_999) begin
                digit_timer <= 0;
                digit_select <= digit_select + 1;
            end
            else begin
                digit_timer <= digit_timer + 1;
            end
        end
    end

    always @(digit_select) begin
        case(digit_select)
            2'b00: an=4'b1110; //Anode 0
            2'b01: an=4'b1101; //Anode 1
            2'b10: an=4'b1011; //Anode 2
            2'b11: an=4'b0111; //Anode 3
        endcase
    end
    
    always @(digit_select, digit1, digit2) begin
        if((digit1 == DASH) && (digit2 == DASH)) begin
            case(digit_select)
                2'b00:begin
                    seg = DASH; //display DASH
                end
                2'b01:begin
                    seg = DASH; //display DASH
                end
                2'b10:begin
                    seg = DASH; //display DASH
                end
                2'b11:begin
                    seg = DASH; //display DASH
                end
            endcase
        end
        else if((digit1 == M) && (digit2 == A)) begin //100%
            case(digit_select)
                2'b00:begin
                    seg = OFF; //display OFF
                end
                2'b01:begin
                    seg = X; //display X
                end
                2'b10:begin
                    seg = A; //display A
                end
                2'b11:begin
                    seg = M; //display M
                end
            endcase
        end
        else begin //All the other case
            case(digit_select)
                2'b00:begin
                    seg = PERC1; //display %
                end
                2'b01:begin
                    seg = PERC2; //display %
                end
                2'b10:begin
                    seg = digit2; //display digit2
                end
                2'b11:begin
                    seg = digit1; //display digit1
                end
            endcase
        end
    end
endmodule