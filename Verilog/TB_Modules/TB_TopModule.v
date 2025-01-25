`include "/c:..."

module TB;
    parameter N = 2;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    //-----------------------
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    
    reg value;
    wire [2:0] symbol;
    wire calculated;
    
    reg clk, rst;
    reg en_ins, en_init, en_read, we;
    wire signed [8:0] max; //chamge to output
    reg change_index;      
    wire end_filling;
    wire [1:0] count_3;
    wire [addr_lenght:0] addr_r;
    wire signed [8:0] diag, up, left, score;
    wire signal;
    wire [BitAddr:0] i, j;
    wire signed [8:0] data_init;
    wire [BitAddr:0] addr_init;
    wire end_init;
    wire hit;
    
    wire signed [8:0] diag_calc, up_calc, lx_calc;
    
    TopModule #(.N(N)) TOP (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init),
        .en_read(en_read),
        .we(we),
        .addr_init(addr_init),
        .max(max),
        .data_init(data_init),
        .change_index(change_index),
        .end_filling(end_filling),
        .count_3(count_3),
        .addr_r(addr_r),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .signal(signal),
        .i(i),
        .j(j),
        .end_init(end_init),
        .hit(hit),
        
        .value(value),
        .symbol(symbol),
        .calculated(calculated),
        
        .diag_calc(diag_calc),
        .up_calc(up_calc),
        .lx_calc(lx_calc)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk = 0; 
        rst = 1; 
        en_ins = 0;
        en_init = 0; 
        en_read = 0;
        value = 0;
        //max = 0;
        we = 0;
        change_index = 0;

        #8.5 rst = 0;
        
        // Initialization phase
        en_init = 1; 
        we = 1;
            
        // Reading phase - ora automatica grazie all'Insertion_Counter
        #12 en_read = 1; 
        en_init = 0; 
        we = 0; 
        en_ins = 0;
        value = 1;
        // Insertion phase
        #12 en_read=0;
        en_init = 0;
        en_ins = 1; 
        we=1;
        
        
        //max = 7; // cella (1,1)
        
        #4 en_read=1;
        en_init = 0; 
        we = 0; 
        en_ins = 0;
        change_index=1;
        #1 change_index=0;
        value = 0;
        // Insertion phase
        #12 en_read=0;
        en_init = 0;
        en_ins = 1; 
        we=1;
        
        
        //max = 8; // cella (1,2)
        
        #4 en_read=1;
        en_init = 0; 
        we = 0; 
        en_ins = 0;
        change_index=1;
        #1 change_index=0;
        value =1;
        // Insertion phase
        #12 en_read=0;
        en_init = 0;
        en_ins = 1; 
        we=1;
        
        
        //max = 13; // cella (2,1)
        
        #4 en_read=1;
        en_init = 0; 
        we = 0; 
        en_ins = 0;
        change_index=1;
        #1 change_index=0;
        value = 0;
        // Insertion phase
        #12 en_read=0;
        en_init = 0;
        en_ins = 1; 
        we=1;
        
        //max = 14; // cella (2,2)
        
        #12 en_ins = 0; we=0;
        
        #40 $stop;
    end
endmodule