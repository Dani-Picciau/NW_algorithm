`include "/c:.../Writing_index_score.v"

module TB_Writing_index_score();

    parameter N = 5;
    parameter BitAddr = $clog2(N);
    parameter addr_lenght = (((N+1)*(N+1))-1);
    
    reg clk, rst;
    reg en_ins, en_init,hit;
    reg [BitAddr:0] i, j, addr_init;
    reg [8:0] max, data_init;
    wire [addr_lenght:0] addr_out;
    wire [8:0] data_out;

    Writing_index_score #(
        .N(N)
    ) WIS_test (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init),
        .hit(hit),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .max(max),
        .data_init(data_init),
        .addr_out(addr_out),
        .data_out(data_out)
    );

    always #2 clk = ~clk;

    initial begin 
        // Initialization of signals
        clk = 0; rst=1; en_ins = 0; en_init = 0; hit=0; i=0; j=0; addr_init=0; max=0; data_init=0;

        #4  rst=0;
            //initialization addres and data
            en_init=1;
            addr_init=0;
            data_init=0;
            hit=0; //first row
        #8  hit=1; //first column
        // put it back to 0
        #8  hit=0; 
            addr_init=1;
            data_init=1;
        #8  hit=1; //first column
        #8  hit=0;// put it back to 0

            //Insertion address and data
            en_init=0;
            en_ins=1;
            i=0;
            j=0;
            max=3;
        #4  i=1;
            j=0;
            max=6;
        #20
        $stop;
    end
endmodule