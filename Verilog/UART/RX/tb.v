`include "/c:.../"
`timescale 1ns / 1ps

module tb; 
    parameter  DATA_BITS = 8,
               STOP_TICK = 16,
               BR_COUNT  = 651,
               BR_BITS   = 10,
               FIFO_EXP  = 9,
               Ram_ADDR  = 4,
               CHAR      = 3,
               N=4, 
               Bit = $clog2(N+1);
    
    // Input signals
    reg clk, rst, rx_done/*,btn*/;
    reg [DATA_BITS-1:0] rx;
    
    reg [Bit:0] addr_dout;
    reg en_dout;
    wire [2:0] dout;
    
    // Output signals
    wire [CHAR-1:0] Seq;
    wire weA, weB,not_valid;    // Aggiungiamo monitor sui segnali di write enable
   // wire rx_empty, rx_full;  // Monitor sui segnali della FIFO
    wire [7:0] fifo_out;
    wire [Ram_ADDR-1:0] address_ramA, address_ramB;
    
    wire hit17;
    wire en_btn;
    wire btn;
    
    // Instantiate the Unit Under Test (UUT)
    uart_top #(.DATA_BITS(DATA_BITS), .STOP_TICK(STOP_TICK), .BR_COUNT(BR_COUNT), .BR_BITS(BR_BITS), 
        .FIFO_EXP(FIFO_EXP), .Ram_ADDR(Ram_ADDR), .CHAR(CHAR)) 
    UUT (
        .clk(clk), 
        .rst(rst), 
        .rx_done(rx_done), 
        .rx_fifo_in(rx), 
        .btn(btn),
        .Seq(Seq),
        .weA(weA),
        .weB(weB),
        .not_valid(not_valid),
        .fifo_out(fifo_out),
        .addr_dout(addr_dout),
        .en_dout(en_dout),
        .dout(dout),
        .address_ramA(address_ramA),
        .address_ramB(address_ramB),
        .hit17(hit17),
        .en_btn(en_btn)
    );
        
    // Clock generation    
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin 
        // Inizializzazione
        clk = 0;
        rst = 1;
//        btn = 0;
        rx_done = 0;
        rx=8'h00;
        addr_dout = 0;
        en_dout = 0;
      
       
        
        // Reset release
        #15 rst = 0;
        
        // Test Case 1: Sequenza valida
        $display("Test Case 1: Inserimento sequenza valida");
        
        
        #10 rx_done = 1; rx = 8'h41;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h43;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h47;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h54;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h23;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h54;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h47;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h43;
        #10 rx_done = 0;
        #10 rx_done = 1; rx = 8'h41;
        #10 rx_done = 0;

        // Termina simulazione
    #500 $display("Simulazione completata");
        $stop;
    end
    
    

endmodule