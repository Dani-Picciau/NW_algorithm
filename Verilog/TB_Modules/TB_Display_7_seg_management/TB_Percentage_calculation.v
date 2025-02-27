`include "/c:.../Percentage_calculation.v"

module TB_Percentage_calculation;
    parameter N = 128;
    parameter score_lenght = $clog2(N+1);
    
    reg signed [score_lenght:0] final_score;
    wire [6:0] percentage;
    
    Percentage_calculation #(
        .N(N)
    ) P_c (
        .final_score(final_score),
        .percentage(percentage)
    );
    
    initial begin
            final_score=-2; //-2 from -128 to 128 equals to 49%
        #5  final_score=0; //0 from -128 to 128 equals to 50%
        #5  final_score=-128; //0 from -128 to 128 equals to 0%
        #5  final_score=128; //0 from -128 to 128 equals to 100%
        #5  final_score=64; //0 from -128 to 128 equals to 75%
        #5
        $stop;
    end
endmodule