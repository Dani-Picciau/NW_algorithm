`include "/c:.../Score_manager.v"

module TB;
    parameter N = 5;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1)));
    
    //The signals are positioned for better understanding of the simulation, do not move them!
    reg clk, rst;
    reg we, en_init;
    
    reg [BitAddr:0] addr_init;
    reg [8:0] data_init;
    wire [addr_lenght-1:0] addr_w; //Internal wire
    wire [8:0] data; //Internal wire
    wire hit; //Internal wire
    reg en_ins;
    reg [BitAddr:0] i, j;
    reg [8:0] max;
    
    reg en_read;
    wire [1:0] count_3; //Internal wire
    wire [addr_lenght-1:0] addr_r; //Internal wire
    reg change_index;
    wire signal;
    wire [8:0] score; //Internal wire
    
    wire [8:0] diag, up, left;
    
    Score_manager # (
        .N(N)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init), 
        .en_read(en_read),
        .we(we),
        .addr_init(addr_init),
        .data_init(data_init),  
        .max(max), 
        .hit(hit),
        .addr_w(addr_w),
        .data(data),
        .i(i), 
        .j(j),
        .count_3(count_3),
        .addr_r(addr_r),
        .signal(signal),
        .change_index(change_index),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score)
    );
    
    always #0.5 clk = ~clk;
    
    //Simulation of the state machine signal "Change_index"
    always@(signal) begin
        #1
        change_index = 1;
        #1
        change_index = 0;
    end

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
        change_index = 0;

        #8  rst=0;
        // Initialization of addres and data
        en_init=1; we = 1;
        addr_init=0;
        data_init=0;

        #4  addr_init=1;
            data_init=16;

        #4  addr_init=2;
            data_init=12;

        // Insertion of address and data
        #4 en_init=0;
            en_ins=1;
            i=0;
            j=0;
            max=7;
        #4  i=0;
            j=1;
            max=8;
        #4  i=1;
            j=0;
            max=13;
        #4  i=1;
            j=1;
            max=14;
            
        // Reading of the addres
        #4.5 en_read=1; en_init=0; we = 0; en_ins=0;
             i=0; j=0;   // I'm reading the cell diag, left and up next to (1,1) because of the +1 for i and j in the code
        #12  i=0; j=1;   // I'm reading the cell diag, left and up next to (1,2) because of the +1 for i and j in the code
        #12  i=1; j=0;   // I'm reading the cell diag, left and up next to (2,1) because of the +1 for i and j in the code        
        #12  i=1; j=1;   // I'm reading the cell diag, left and up next to (2,2) because of the +1 for i and j in the code     
        #12 en_read=0;
        
        #40
        $stop;
    end
endmodule