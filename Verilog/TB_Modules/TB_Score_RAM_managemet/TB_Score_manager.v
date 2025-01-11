`include "/c:..."

module TB_Score_manager;
    parameter N = 5;
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
    reg en_counter_3;

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
        addr, 
        data_in,
        max,  
        i, j,
        en_counter_3,
        signal,
        diag, 
        left, 
        up
    );

    always #1 clk = ~clk;

    initial begin
        // Initializzation of signals
        clk = 0; rst = 1; we = 0; en_ins = 0; en_init = 0; en_read = 0; addr = 0; data_in = 0; max = 0; i = 0; j = 0;  en_counter_3 = 0;

        // Initializzation of the ram
        #5  rst = 0; 
            en_init = 1; we = 1; 
            addr = 0; data_in = 0;
        #5  addr = 1; data_in = -1;

        // Reading into the ram
        #5  we = 0; en_init = 0;
        #5  en_read = 1; 
            i = 1; j = 1; //Because i have to read the diagonal, up and left cell next to the (1,1) cell
            en_counter_3 = 1;
        
        //Writing into the ram
        #30 en_ins = 1; en_read = 0; we = 1;
            i = 0; j = 0; max = 3;
        #5  i = 1; j = 0; max = 1;
        #5  i = 0; j = 1; max = 2;

        // Reading into the ram
        #5  we = 0; en_init = 0;
        #5  en_read = 1; 
            i = 2; j = 2; //Because i have to read the diagonal, up and left cell next to the (2,2) cell
            en_counter_3 = 1;

        #50
        $stop;
    end
endmodule