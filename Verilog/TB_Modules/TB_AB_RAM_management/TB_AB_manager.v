`include "/c:.../AB_manager.v"

module TB;
    parameter N=5;
    parameter BitAddr=$clog2(N+1);

    reg clk, rst;
    reg en_traceB,en_read;
    reg [BitAddr:0] i, i_t, j, j_t;
    wire [2:0] doutA, doutB;
    wire [BitAddr:0] indexA, indexB;
    
    AB_manager #(
        .N(N)
    ) block1 (
        .clk(clk),
        .rst(rst),
        .en_traceB(en_traceB),
        .en_read(en_read),      
        .i(i),
        .j(j),
        .i_t(i_t),
        .j_t(j_t),
        .doutA(doutA),
        .doutB(doutB),
        .indexA(indexA),
        .indexB(indexB)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk=0;
        rst=1;
        en_traceB=0;
        en_read=0;
        i=0;
        j=0;
        i_t=0;
        j_t=0;
        
        #8.5 rst=0;
        
        en_read=1;
        #5 i=0; j=0;
        #5 i=0; j=1;
        #5 i=0; j=2;
        #5 i=0; j=3;
        #5 i=0; j=4;
        #5 i=1; j=0;
        #5 i=1; j=1;
        #5 i=1; j=2;
        #5 i=1; j=3;
        #5 i=1; j=4;
        #5 i=2; j=0;
        #5 i=2; j=1;
        #5 i=2; j=2;
        #5 i=2; j=3;
        #5 i=2; j=4;
        #5 i=3; j=0;
        #5 i=3; j=1;
        #5 i=3; j=2;
        #5 i=3; j=3;
        #5 i=3; j=4;
        #5 i=4; j=0;
        #5 i=4; j=1;
        #5 i=4; j=2;
        #5 i=4; j=3;
        #5 i=4; j=4;
        
        #5 en_read=0; en_traceB=1;
           i_t=0; j_t=0;
        #5 i_t=0; j_t=1;
        #5 i_t=0; j_t=2;
        #5 i_t=0; j_t=3;
        #5 i_t=0; j_t=4;
        #5 i_t=1; j_t=0;
        #5 i_t=1; j_t=1;
        #5 i_t=1; j_t=2;
        #5 i_t=1; j_t=3;
        #5 i_t=1; j_t=4;
        #5 i_t=2; j_t=0;
        #5 i_t=2; j_t=1;
        #5 i_t=2; j_t=2;
        #5 i_t=2; j_t=3;
        #5 i_t=2; j_t=4;
        #5 i_t=3; j_t=0;
        #5 i_t=3; j_t=1;
        #5 i_t=3; j_t=2;
        #5 i_t=3; j_t=3;
        #5 i_t=3; j_t=4;
        #5 i_t=4; j_t=0;
        #5 i_t=4; j_t=1;
        #5 i_t=4; j_t=2;
        #5 i_t=4; j_t=3;
        #5 i_t=4; j_t=4;
        
        #10 $stop;
    end
endmodule