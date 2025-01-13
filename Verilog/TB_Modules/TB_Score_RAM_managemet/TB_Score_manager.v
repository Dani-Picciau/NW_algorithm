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

/* testbanch che stiamo usando adesso per i test:

module TB;
    parameter N = 5;
    parameter BitAddr = $clog2(N);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    
    reg clk, rst;
    reg en_ins, en_init, en_read, we;
    reg[BitAddr:0] i, j, addr_init;
    reg[8:0] max, data_init;
    reg [1:0] count_3;
    wire [8:0] score;
    wire valid;
    wire [addr_lenght:0] addr_r;
     
    TopModule # (
        .N(N)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init), 
        .en_read(en_read),
        .we(we),
        .i(i), 
        .j(j), 
        .addr_init(addr_init), 
        .max(max), 
        .data_init(data_init), 
        .count_3(count_3),
        .score(score),
        .valid(valid),
        .addr_r(addr_r)
    );
    
    

    always #0.5 clk = ~clk;

    initial begin
        clk = 0; 
        rst = 1; 
        en_ins= 0;
        en_init= 0; 
        en_read = 0;
        we = 0;
        i = 0; 
        j = 0; 
        addr_init = 0; 
        max = 0; 
        data_init = 0;
        count_3=00;

        #8  rst=0;
        // Initialization of addres and data
        en_init=1; we = 1;
        addr_init=0;
        data_init=0;

        #8  addr_init=1;
            data_init=16;

        #8  addr_init=2;
            data_init=12;

        // Insertion of address and data
        #10 en_init=0;
            en_ins=1;
            i=0;
            j=0;
            max=7;
        #4  i=1;
            j=0;
            max=13;
        #4  i=0;
            j=1;
            max=8;
        #4  i=1;
            j=1;
            max=14;
            
        // Reading of the addres
        #4.5 en_read=1; en_init=0; we = 0; en_ins=0;
            i=0; j=0;   // I'm reading the cell diag, left and up next to (1,1) because of the +1 for i and j in the code
            count_3=00; // diag (0,0) -> 0
        #4  count_3=01; // left (1,0) -> 16
        #4  count_3=10; // up (0,1) -> 16
        
        #4  i=0; j=1;   // I'm reading the cell diag, left and up next to (1,2) because of the +1 for i and j in the code
            count_3=00; // diag (0,1) -> 16
        #4  count_3=01; // left (1,1) -> 7
        #4  count_3=10; // up (0,2) -> 12
        
        #4  i=1; j=0;   // I'm reading the cell diag, left and up next to (2,1) because of the +1 for i and j in the code
            count_3=00; // diag (1,0) -> 16
        #4  count_3=01; // left (2,0) -> 12
        #4  count_3=10; // up (1,1) -> 7
        
        #4  i=1; j=1;   // I'm reading the cell diag, left and up next to (2,2) because of the +1 for i and j in the code
            count_3=00; // diag (1,1) -> 7
        #4  count_3=01; // left (2,1) -> 13
        #4  count_3=10; // up (1,2) -> 8
         
        #4 en_read=0;
        #40
        $stop;
    end
endmodule
*/