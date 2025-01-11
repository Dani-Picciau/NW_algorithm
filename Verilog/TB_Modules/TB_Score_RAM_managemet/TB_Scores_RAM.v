`include "/c:.../Score_RAM.v"

module TB_Score_RAM;
    
    //parameter
    parameter N=128; 
    parameter BitAddr = $clog2(N+1);
    //inputs
    reg clk, rst;
    reg [8:0] din;
    reg en_din, en_dout, we; //en_din is an OR between en_ins and en_init
    reg [BitAddr:0] addr_din; 
    reg [BitAddr:0] addr_dout;
    //output
    wire [8:0] dout;

    Scores_RAM #(.N(N)) S_RAM (
        clk, 
        rst,
        din,
        en_din, 
        en_dout, 
        we,
        addr_din,
        addr_dout,
        dout,
    )

    always #1 clk = ~clk;

    initial begin
        clk = 0; rst = 1; 
        din = 9'b0; 
        en_din = 0; en_dout = 0; we = 0;
        addr_din = 0; 
        addr_dout = 0; 

        #5 rst = 0;
        en_din =1 ; we = 1;
        addr_din = 0; din = 1;
        #5
        addr_din = 1; din = 5;
        #5
        en_din = 0; we = 0;
        en_dout = 1;
        addr_dout = 0;
        #5
        addr_dout = 1;
    end

    //commento
endmodule