`include "/c:/Users/dany2/OneDrive/Desktop/Documenti/GitHub/NW_algorithm/Verilog/Moduli/Direction_RAM.v"

module TB_Direction_RAM;
    reg clk, rst;
    reg en_ins, we, en_traceB, en_init;
    reg [2:0] i_in, j_in, i_t, j_t, addr;
    reg [2:0] symbol_in;
    wire [2:0] symbol_out;
    
    Direction_RAM #(5) test(
        .clk(clk), 
        .rst(rst),
        .en_ins(en_ins), 
        .we(we), 
        .en_traceB(en_traceB), 
        .en_init(en_init),
        .i_in(i_in), 
        .j_in(j_in), 
        .i_t(i_t), 
        .j_t(j_t), 
        .addr(addr),
        .symbol_in(symbol_in), 
        .symbol_out(symbol_out)  
    );
    
    always #0.5 clk=~clk;
    initial begin
        //Inizializzazione dei segnali
        clk=0; rst=1; en_init=0; en_ins=0; we=0; en_traceB=0;  addr=0; i_in=0; j_in=0; i_t=0; j_t=0; symbol_in=0;
        
        //Inizializzazione delle celle di gap con i simboli
        #5 rst=0; en_init=1; en_ins=0; we=1; en_traceB=0; 
        #2 addr=0;
        #2 addr=1;
        #2 addr=2;
        
        //Scrittura dei simboli a partire dalla posizione (1,1) della matrice
        #10 en_init=0; en_ins=1; we=1; en_traceB=0;
            i_in=0; j_in=0;
            symbol_in=3'b010;
        #2 i_in=0; j_in=1;       
           symbol_in=3'b001;
        #2 i_in=1; j_in=0;
           symbol_in=3'b001;       
        #2 i_in=1; j_in=1;
           symbol_in=3'b100;   
        #2 i_in=0; j_in=2;
           symbol_in=3'b010; 
        
        //Lettura dei valori inseriti
        #5 en_traceB=1; we=0; en_ins=0;
           i_t=0; j_t=0;
        #2 i_t=0; j_t=1;       
        #2 i_t=1; j_t=0;
        #2 i_t=1; j_t=1;
        #2 i_t=0; j_t=2;
        #2 i_t=2; j_t=0;
        #2 i_t=2; j_t=2;
        
        #5
        $stop;
    end
endmodule

