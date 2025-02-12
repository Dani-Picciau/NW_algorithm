`include "/c:..."

module TB;
    parameter N = 5;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    //-----------------------
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    
    reg clk, rst;
    reg [2:0] a, b;
    reg change_index;
    reg en_ins, en_init, en_read, en_traceB, we; 
    wire signal;    
    wire calculated;
    wire end_init;
    wire end_filling;
    wire [2:0] symbol_out;
    wire end_c;
    wire [BitAddr:0] i_t_ram, j_t_ram;
    
    //Internal wires
    wire [BitAddr:0] i_t, j_t;
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
    wire value;
    
    TopModule #(.N(N)) TOP (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
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
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram),
        .i_t(i_t),
        .j_t(j_t),
        .i(i),
        .j(j),
        .end_init(end_init),
        .hit(hit), 
        .symbol(symbol),
        .symbol_w(symbol_w),
        .symbol_out(symbol_out),
        .calculated(calculated),
        .value(value),
        .end_c(end_c)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk = 0; 
        rst = 1; 
        a = 0;
        b = 0;
        en_ins = 0;
        en_init = 0; 
        en_read = 0;
        en_traceB = 0;
        we = 0;
        change_index = 0;

        #8.5 rst = 0;
        
        // Initialization phase
        en_init = 1; 
        we = 1;
            
        // Reading phase - ora automatica grazie all'Insertion_Counter
        #24 en_read = 1; 
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            a = 110; //C
            b = 001; //G
            // cella (1,1)
            #4
            //value = 1; //match
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 100; //A
            // cella (1,2)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;

        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1; 
        #1  change_index=0;
            a = 110; //C
            b = 011; //T
            // cella (1,3)
            #1
            //value =1; // match
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;

        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 001; //G
            // cella (1,4)
            #1
            //value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 110; //C
            // cella (1,5)
            #1
            //value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 100; //A
            b = 001; //G
            // cella (2,1)
            #1
            //value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 100; //A
            b = 100; //A
            // cella (2,2)
            #1
            //value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 100; //A
            b = 011; //T
            // cella (2,3)
            #1
            //value = 0; // mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 100; //A
            b = 001; //G
            // cella (2,4)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 100; //A
            b = 110; //C
            // cella (2,5)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 001; //G
            // cella (3,1)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 100; //A
            // cella (3,2)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 011; //T
            // cella (3,3)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
        
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 001; //G
            // cella (3,4)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 110; //C
            b = 110; //C
            // cella (3,5)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 011; //T
            b = 001; //G
            // cella (4,1)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 011; //T
            b = 100; //A
            // cella (4,2)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 011; //T
            b = 011; //T
            // cella (4,3)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            a = 011; //T
            b = 001; //G
            // cella (4,4)
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
        
        #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (4,5)
            a = 011; //T
            b = 110; //C
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
            
            #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (5,1)
            a = 001; //G
            b = 001; //G
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
            
            #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (5,2)
            a = 001; //G
            b = 100; //A
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
            
            #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (5,3)
            a = 001; //G
            b = 011; //T
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
            
            #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (5,4)
            a = 001; //G
            b = 001; //G
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
            
            
            #4  en_read=1;
            en_init = 0; 
            we = 0; 
            en_ins = 0;
            change_index=1;
        #1  change_index=0;
            // cella (5,5)
            a = 001; //G
            b = 110; //C
            #1
            //value = 0; //mismatch
        // Insertion phase
        #12 en_read=0;
            en_init = 0;
            en_ins = 1; 
            we=1;
       
        
        #12 en_ins = 0;
            en_init = 0; 
            en_read = 0;
            we=0;
            en_traceB = 1;
        
        #40 $stop;
    end
endmodule