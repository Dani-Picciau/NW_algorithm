module TB;
//Parameters
    parameter N = 5;
    parameter BitAddr = $clog2(N);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    
    reg clk, rst;
    reg en_ins, en_init,hit;
    reg [BitAddr:0] i, j, addr_init;
    reg [2:0] symbol;
    wire [addr_lenght:0] addr_out;
    wire [2:0] symbol_out;

    Writing_index_direction #(
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
        .symbol(symbol),
        .addr_out(addr_out),
        .symbol_out(symbol_out)
    );

    always #0.5 clk = ~clk;

    initial begin 
        // Initialization of signals
        clk = 0; rst=1; en_ins = 0; en_init = 0; hit=0; i=0; j=0; addr_init=0; symbol=0;

        #4.5  rst=0;
            //initialization addres and data
            en_init=1;
            addr_init=0;
            symbol=1;
            hit=0; //first row
        #8  hit=1; //first column
        // put it back to 0
        #8  hit=0; 
            addr_init=1;
            symbol=2;
        #8  hit=1; //first column
        #8  hit=0;// put it back to 0

            //Insertion address and data
            en_init=0;
            en_ins=1;
            i=0;
            j=0;

        #4  i=1;
            j=0;
        #20
        $stop;
    end
endmodule
