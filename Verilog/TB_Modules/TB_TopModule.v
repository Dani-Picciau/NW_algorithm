`include "/c:..."

module TB;
    parameter N = 7;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    //-----------------------
    parameter gap_score = -2;
    parameter match_score = 1;
    parameter mismatch_score = -1;
    
    reg clk, rst;
    reg ready;
    
    //Input fsm
    wire end_init;
    wire calculated;
    wire signal;
    wire end_filling;
    wire end_traceB;
    wire hit_4;
    
    //Output fsm
    wire we;
    wire en_init;
    wire en_ins;
    wire en_read;
    wire en_traceB;
    wire change_index;
    wire [2:0] state;reg clk, rst;
    reg ready;
    
    //Input fsm
    wire end_init;
    wire calculated;
    wire signal;
    wire end_filling;
    wire end_traceB;
    wire hit_4;
    
    //Output fsm
    wire we;
    wire en_init;
    wire en_ins;
    wire en_read;
    wire en_traceB;
    wire change_index;
    wire [2:0] state;
    
    // internal wires dp
    wire [BitAddr:0] indexA, indexB;
    wire [2:0] doutA, doutB;
    
    wire value;
    wire [BitAddr:0] i, j;
    wire hit;
    wire [BitAddr:0] addr_init;
    wire signed [8:0] data_init, data;
    wire signed [8:0] diag, up, left, score;
    wire signed [8:0] max;
    wire [2:0] symbol, symbol_w;
    wire [1:0] count_3;
    wire [addr_lenght:0] addr_r_sc, addr_w_sc;
    wire [addr_lenght:0] addr_r_dir, addr_w_dir;
    
    wire [BitAddr:0] i_t, j_t;
    wire [2:0] symbol_out;
    wire [BitAddr:0] i_t_ram, j_t_ram;
    
    wire signed [BitAddr:0] final_score;
    wire [2:0] datoA, datoB;

    
    TopModule #(
        .N(N)
    ) TOP (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .end_init(end_init),
        .calculated(calculated),
        .signal(signal),
        .end_filling(end_filling),
        .end_traceB(end_traceB),
        .en_ins(en_ins),
        .en_init(en_init),
        .en_read(en_read),
        .en_traceB(en_traceB),
        .we(we),
        .change_index(change_index),
        .state(state),
        .indexA(indexA),
        .indexB(indexB),
        .doutA(doutA),
        .doutB(doutB),
        .value(value),
        .i(i),
        .j(j),
        .hit(hit),
        .addr_init(addr_init),
        .data_init(data_init),
        .data(data),
        .diag(diag),
        .up(up),
        .left(left),
        .score(score),
        .max(max),
        .symbol(symbol),
        .symbol_w(symbol_w),
        .count_3(count_3),
        .addr_r_sc(addr_r_sc),
        .addr_w_sc(addr_w_sc),
        .addr_r_dir(addr_r_dir),
        .addr_w_dir(addr_w_dir),
        .i_t(i_t),
        .j_t(j_t),
        .symbol_out(symbol_out),
        .i_t_ram(i_t_ram),
        .j_t_ram(j_t_ram),
        .hit_4(hit_4),
        .final_score(final_score),
        .datoA(datoA),
        .datoB(datoB)
    );

    always #0.5 clk = ~clk;
    
    initial begin
        clk = 0; 
        rst = 1;
        ready = 0; 
        
        #8.5 rst = 0;
        #5 ready = 1;
        #5 ready = 0;
        //#480 $stop;
    end
    
    //end
endmodule