`include "/c:.../Direction_manager.v"

module TB;
    parameter N=5;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    
    //The signals are positioned for better understanding of the simulation, do not move them!
    reg clk, rst;
    
    reg we, en_init;
    wire hit; //Internal wire
    reg [BitAddr:0] addr_init;
    reg [2:0] symbol_in;
    wire [2:0] symbol_w; //Internal wire
    wire [addr_lenght:0] addr_w; //Internal wire
    
    reg en_ins;
    reg [BitAddr:0] i, j;
    
    reg en_traceB;
    reg [BitAddr:0] i_t, j_t;
    wire [addr_lenght:0] addr_r; //Internal wire
    wire [2:0] symbol_out;
       
    Direction_manager #(
        .N(N)
    ) D_m (
        .clk(clk),
        .rst(rst),
        .we(we),
        .en_init(en_init),
        .en_ins(en_ins),
        .en_traceB(en_traceB),
        .i_t(i_t),
        .j_t(j_t),
        .i(i),
        .j(j),
        .addr_init(addr_init),
        .symbol_in(symbol_in),
        .symbol_out(symbol_out),
        
        //Internal wire
        .addr_r(addr_r),
        .addr_w(addr_w),
        .hit(hit),
        .symbol_w(symbol_w)
    );
    
    always #0.5 clk = ~clk;
    
    initial begin
        clk=0;
        rst=1;
        we=0;
        en_init=0;
        en_ins=0;
        en_traceB=0;
        i_t=0;
        j_t=0;
        i=0;
        j=0;
        addr_init=0;
        symbol_in=0;
        
        #4.5 rst=0;
        
        //Initializzation of the writing: first row and first column
        en_init=1; we=1;
        #4 addr_init = 1;
        #4 addr_init = 2;
        #4 addr_init = 3;
        
        //Initializzation of the writing: internal value
        #4 en_ins=1; en_init=0; 
        #4 i=0; j=0; symbol_in = 3'b010;
        #4 i=0; j=1; symbol_in = 3'b100;   
        #4 i=1; j=0; symbol_in = 3'b001;  
        #4 i=1; j=1; symbol_in = 3'b010;
        #2 we=0; en_init=0; en_ins=0;
        
        //Initializzation of the reading
        #4 en_traceB=1;
           i_t=0; j_t=0; 
        #4 i_t=0; j_t=1; 
        #4 i_t=1; j_t=0; 
        #4 i_t=1; j_t=1; 
        #30
        $stop; 
    end
endmodule