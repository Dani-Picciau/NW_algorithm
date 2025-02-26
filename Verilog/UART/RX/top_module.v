`include "/c:.../"
module uart_top #(parameter
    N=4,
    DATA_BITS = 8,
    STOP_TICK = 16,
    BR_COUNT  = 651,
    BR_BITS   = 10,
    FIFO_EXP  = 9,
    Ram_ADDR  = 1,
    CHAR      = 3,
    Bit = $clog2(N+1)
    
) (
    input wire clk, rst, rx,
    output wire [Ram_ADDR-1:0] address_ramA, address_ramB,
    output wire [CHAR-1:0] Seq,
    output wire weA,weB,enable_ram 
); 
   // USCITE: Enable per le Ram, I Dati delle Ram, Gli indirizzi delle Ram 
    
// Connection Signals rx_fifo_in,
    wire [DATA_BITS-1:0] rx_fifo_in,fifo_out;
    wire rx_full, rx_empty, btn_tick,not_valid,hit17,en_btn,btn;
//    wire [7:0] fifo_out;
    wire [FIFO_EXP-1:0] address_fifo;
   // wire [Ram_ADDR-1:0] address_ramA, address_ramB;
     

    //Control signals
    wire tick;
    wire rx_done;      
   

       
       //Connecting all modules
    baud_rate_generator #(.N(BR_BITS), .COUNT(BR_COUNT)) 
    baud_rate_gen_module (.clk(clk), .rst(rst), .tick(tick));
    
    uart_receiver       #(.DATA_BITS(DATA_BITS), .STOP_TICK(STOP_TICK)) 
    uart_rx_module       (.clk(clk), .rst(rst), .rx_data(rx), .sample_tick(tick), 
                          .data_out(rx_fifo_in), .data_ready(rx_done));
        
   Counter_data17 cnt17(.clk(clk), .rst(rst),.data_ready(rx_done),.hit(hit17));
   
    fifo #(
        .DATA_SIZE(DATA_BITS), 
        .ADDR_SIZE_EXP(FIFO_EXP)
   ) fifo_rx_module (
        .clk(clk), 
        .rst(rst), 
        .rd_from_fifo(btn), 
        .wr_to_fifo(rx_done),
        .wr_data_in(rx_fifo_in), 
        .rd_data_out(fifo_out),
        .address_out(address_fifo),
        .empty(rx_empty),
        .full(rx_full)
    );
   
    
   
    cod_in #(.N(8))
        Cod_in(.clk(clk),.rst(rst),.btn(btn),.fifo_data_out(fifo_out), .char(Seq));
    
    check_data  
        check(.data(Seq),.clk(clk),.rst(rst),.not_valid(not_valid));
    
    Counter_btn cnt_btn(
        .clk(clk), 
        .rst(rst), 
        .en_btn(en_btn), 
        .btn(btn)
     );
    
    gest_add #(.ADDR(1),.N()) 
        gest(.clk(clk), .rst(rst),.weA(weA),.weB(weB),.fifo_out(fifo_out),.Seq(Seq), .addr_rA(address_ramA), .addr_rB(address_ramB));
    
    fsm fsm(
        .clk(clk),
        .rst(rst),
        .notvalid(not_valid),
        .fifo_empty(rx_empty),
        .btn(hit17),
        .weA(weA),
        .weB(weB),
        .en(enable_ram),
        .en_btn(en_btn)
    );


//If you want to try rams's initialization with a testbench, uncom these rows 

//    RAM_A #(.N(N),.Bit())
//        I(.clk(clk), .rst(rst), .din(Seq), .en_din(enable_ram), .en_dout(), .we(weA), .addr_din(address_ramA), .addr_dout(addr_dout), .dout());
        
//    RAM_B #(.N(N),.Bit() )
//        II(.clk(clk), .rst(rst), .din(Seq), .en_din(enable_ram), .en_dout(), .we(weB), .addr_din(address_ramB), .addr_dout(), .dout());

 endmodule