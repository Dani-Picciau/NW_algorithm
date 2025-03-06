`include "c:\..."
 
`include "Percentage_calculation.v"
`include "Splitter.v"
`include "Converter.v"
`include "Display_7_seg.v"

module Display_7_seg_manager #(
    parameter N = 5
) (
    input wire clk, rst,
    input wire signed [8:0] submit_value,
    output wire [6:0] seg, // Cathodes for each anode
    output wire [3:0] an   // Anodes for each digit
);
    wire [8:0] percentage;
    wire [4:0] Tens;
    wire [3:0] Units;
    wire [6:0] digit1, digit2;
    
    Percentage_calculation #(
        .N(N)
    ) P_c (
        .final_score(submit_value),
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
        .rst(rst),
        .digit1(digit1),
        .digit2(digit2),
        .seg(seg),
        .an(an)
    );
endmodule