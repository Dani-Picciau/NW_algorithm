`include "/c:.../Match_mismatch.v"

module TB_Match_mismatch;
    reg [2:0] a, b;
    wire value;
    
    Match_mismatch Mm(
        .a(a),
        .b(b),
        .value(value)
    );
    
    initial begin
           a=0; b=0;
        #5 a=0; b=1;
        #5 a=1; b=0;
        #5 a=1; b=1;
        #5
        $stop;
    end
endmodule