`include "/c:..."

module TB;
    parameter N = 5;
    parameter BitAddr = $clog2(N);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    
    reg clk, rst;
    reg en_ins, en_init, en_read, we;
    reg [BitAddr:0] i, j, addr_init;
    reg [8:0] max, data_init;
    reg [1:0] count_3;
    wire [addr_lenght:0] addr_r;
    wire [8:0] diag, left, up, score;
    wire ready;
     
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
        .addr_r(addr_r),
        .diag(diag),
        .left(left),
        .up(up),
        .score(score),
        .ready(ready)
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
