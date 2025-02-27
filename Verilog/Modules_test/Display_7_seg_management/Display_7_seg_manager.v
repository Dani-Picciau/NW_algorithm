`include "c:\..."
 
`include "Percentage_calculation.v"
`include "Splitter.v"
`include "Converter.v"
`include "Display_7_seg.v"

module Display_7_seg_manager #(
    parameter N = 5,
    parameter score_lenght= $clog2(N+1)
) (
    input wire clk, rst,
    input wire signed [score_lenght:0] final_score, // Score value
    output reg [6:0] seg, // Cathodes for each anode
    output reg [3:0] an //  Anodes for each digit// Score value
);
    wire [6:0] percentage;
    wire [3:0] Tens, Units;
    wire [6:0] digit1, digit2;

    Percentage_calculation #(
        .N(N)
    ) P_c (
        .final_score(final_score),
        .percentage(percentage)
    );

    Splitter split (
        .Percentage(percentage),
        .Tens(Tens),
        .Units(Units)
    );

    Converter conv (
        .Tens(Tens),
        .Units(Units),
        .digit1(digit1),
        .digit2(digit2)
    );

    Display_7_seg #(
        .N(N)
    ) D_7_s (
        .clk(clk),
        .rst(rts),
        .digit1(digit1),
        .digit2(digit2),
        .seg(seg),
        .an(an)
    );

    //end
endmodule