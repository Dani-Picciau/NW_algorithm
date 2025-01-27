`include "/c:..."

module TB;
    parameter N = 3;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    //-----------------------
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    
    reg clk, rst;
    reg value;
    reg change_index;
    reg en_ins, en_init, en_read, en_traceB, we; 
    reg [BitAddr:0] i_t, j_t;
    wire signal;    
    wire calculated;
    wire end_init;
    wire end_filling;
    wire [2:0] symbol_out;
    
    //Internal wires
    wire [2:0] symbol, symbol_w;
    wire signed [8:0] max;     
    wire [1:0] count_3;
    wire [addr_lenght:0] addr_r_sc, addr_w_sc;
    wire [addr_lenght:0] addr_r_dir, addr_w_dir;
    wire signed [8:0] diag, up, left, score;
    wire [BitAddr:0] i, j;
    wire [BitAddr:0] addr_init;
    wire signed [8:0] data_init, data;
    wire hit;
    
    TopModule #(.N(N)) TOP (
        .clk(clk),
        .rst(rst),
        .en_ins(en_ins),
        .en_init(en_init),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .we(we),
        .addr_init(addr_init),
        .max(max),
        .data_init(data_init),
        .data(data),
        .change_index(change_index),
        .end_filling(end_filling),
        .count_3(count_3),
        .addr_r_sc(addr_r_sc),
        .addr_w_sc(addr_w_sc),
        .addr_r_dir(addr_r_dir),
        .addr_w_dir(addr_w_dir),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .signal(signal),
        .i_t(i_t),
        .j_t(j_t),
        .i(i),
        .j(j),
        .end_init(end_init),
        .hit(hit), 
        .value(value),
        .symbol(symbol),
        .symbol_w(symbol_w),
        .symbol_out(symbol_out),
        .calculated(calculated)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk = 0; 
        rst = 1; 
        en_ins = 0;
        en_init = 0; 
        en_read = 0;
        en_traceB = 0;
        we = 0;
        value = 0;
        change_index = 0;
        i_t = 0;
        j_t = 0;

        #8.5 rst = 0;
        
        // Initialization phase
        en_init = 1; 
        we = 1;
            
        // Reading phase - ora automatica grazie all'Insertion_Counter
        #16 en_read = 1; 
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            value = 1; //match
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 7; // cella (1,1)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1 change_index=0;
            value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;

        //max = 8; // cella (1,2)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1; 
        #1 change_index=0;
            value =1; // match
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;

        //max = 9; // cella (1,3)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 13; // cella (2,1)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 14; // cella (2,2)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 15; // cella (2,3)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 19; // cella (3,1)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 20; // cella (3,2)
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        //max = 21; // cella (3,3)
        
        #12 en_ins = 0;
            en_init = 0; 
            en_read = 0;
            we=0;
            en_traceB = 1;
            i_t=0; j_t=0; 
        #4  i_t=0; j_t=1;
        #4  i_t=0; j_t=2; 
        #4  i_t=1; j_t=0; 
        #4  i_t=1; j_t=1; 
        #4  i_t=1; j_t=2; 
        #4  i_t=2; j_t=0; 
        #4  i_t=2; j_t=1; 
        #4  i_t=2; j_t=2;
        
        #40 $stop;
    end
endmodule