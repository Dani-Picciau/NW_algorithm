`include "/c:/Users/dany2/OneDrive/Desktop/Documenti/GitHub/NW_algorithm/Verilog/Moduli/Direction_RAM.v"

module TB_Direction_RAM;

   // Parameters
   parameter N = 5;
   parameter BitAddr = $clog2(N+1);

   // Input signals
   reg clk;
   reg rst;
   reg en_init;
   reg en_ins;
   reg en_traceB;
   reg we;
   reg en_init;
   reg [BitAddr:0] i_in; 
   reg [BitAddr:0] j_in; 
   reg [BitAddr:0] i_t;
   reg [BitAddr:0] j_t; 
   reg [BitAddr:0] addr;
   reg [2:0] symbol_in;

   // Output signals
   wire [2:0] symbol_out;
   
   // Instantiation of the Direction_RAM module
   Direction_RAM #(.N(N)) test (
      .clk(clk), 
      .rst(rst),
      .en_ins(en_ins), 
      .we(we), 
      .en_traceB(en_traceB), 
      .en_init(en_init),
      .i(i_in), 
      .j(j_in),  
      .i_t(i_t), 
      .j_t(j_t), 
      .addr(addr),
      .symbol_in(symbol_in), 
      .symbol_out(symbol_out)  
   );
   
   // Clock generation
   always #1 clk = ~clk;

   initial begin
      // Initialization of signals
      clk=0; rst=1; en_init=0; en_ins=0; we=0; en_traceB=0;  addr=0; i_in=0; j_in=0; i_t=0; j_t=0; symbol_in=0;
      
      // Initialization of gap cells with symbols
      #5 rst=0; en_init=1; en_ins=0; we=1; en_traceB=0; 
      #2 addr=0;
      #2 addr=1;
      #2 addr=2;
      
      // Writing symbols starting from position (1,1) in the matrix
      #10 en_init = 0; en_ins = 1; we = 1; en_traceB = 0;
         i_in = 0; j_in = 0; symbol_in = 3'b010;
      #2  i_in = 0; j_in = 1; symbol_in = 3'b001;
      #2  i_in = 1; j_in = 0; symbol_in = 3'b001;
      #2  i_in = 1; j_in = 1; symbol_in = 3'b100;
      
      // Reading the inserted values
      #5 en_traceB=1; we=0; en_ins=0;
         i_t=0; j_t=0;
      #2 i_t=0; j_t=1;       
      #2 i_t=1; j_t=0;
      #2 i_t=1; j_t=1;
      #2 i_t=0; j_t=2;
      #2 i_t=2; j_t=0;
      #2 i_t=2; j_t=2;
      #2 i_t=2; j_t=1;
      #2 i_t=1; j_t=2;
      
      #5
      $stop;
   end
endmodule