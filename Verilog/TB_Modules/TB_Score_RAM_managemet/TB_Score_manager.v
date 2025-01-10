`include "/c:..."

module TB_Score_manager;
    parameter N = 128;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);

    reg clk, rst;
    reg we;
    reg en_ins;
    reg en_init;
    reg en_read;
    reg [BitAddr:0] addr; 
    reg [8:0] data_in;
    reg [8:0] max;
    reg [BitAddr:0] i, j;
    reg start_count_3;
    reg en_counter_3;

    wire stop_count_3;
    wire signal;
    wire [8:0] diag, left, up;

    Score_manager #(
        .N(N)
    ) Sm (
        clk, rst,
        we,
        en_ins,
        en_init,
        en_read,
        [BitAddr:0] addr, 
        [8:0] data_in,
        [8:0] max,  
        [BitAddr:0] i, j,
        start_count_3,
        en_counter_3,

        stop_count_3,
        signal,
        [8:0] diag, left, up
    );

    always #2 clk = ~clk;

    initial begin
        //Initializzation of signals
        clk = 0; rst = 1; we = 0; en_ins = 0; en_init = 0; en_read = 0; addr = 0; data_in = 0; max = 0; i = 0; j = 0; start_count_3 = 0; en_counter_3 = 0;

        //Writing into the ram
        #5 rst = 0; 
        en_init = 1; we = 1; //
        addr = 0; data = 0;

        #5  addr = 1; data = -1;
        #5  we = 0; en_init = 0;
        #5  en_read = 1; i = 0; j = 0;
            en_counter_3 = 1; en
        #10
        $stop
    end
endmodule