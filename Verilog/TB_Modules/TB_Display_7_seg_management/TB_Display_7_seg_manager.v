`include "/c:.../Display_7_seg_manager.v"

module TB_Display_7_seg_management;
    parameter N = 5;
    
    reg clk, rst;
    reg signed [8:0] submit_value;
    wire [6:0] seg; // Cathodes for each anode
    wire [3:0] an;   // Anodes for each digit
    
    Display_7_seg_manager # (
        .N(N)
    ) manager (
        .clk(clk),
        .rst(rst),
        .submit_value(submit_value),
        .seg(seg),
        .an(an)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk=0;
        rst=1;
        submit_value=-5;
        #5.5 rst=0;
        
            submit_value=-5;
        #19  submit_value=0;    
        #20  submit_value=5; 
        
        #18 $stop;
    end

endmodule