module TB;

    
    //parameter
    parameter N=5; 
    parameter addr_lenght = $clog2(((N+1)*(N+1))-1);
    //inputs
    reg clk, rst;
    reg signed [2:0] din;
    reg en_din, en_dout, we; //en_din is an OR between en_ins and en_init
    reg [addr_lenght:0] addr_din; 
    reg [addr_lenght:0] addr_dout;
    //output
    wire signed [2:0] dout;

    Direction_RAM #(.N(N)) D_RAM (
        .clk(clk), 
        .rst(rst),
        .din(din),
        .en_din(en_din), 
        .en_dout(en_dout), 
        .we(we),
        .addr_din(addr_din),
        .addr_dout(addr_dout),
        .dout(dout)
    );

    always #0.5 clk = ~clk;

    initial begin
        clk = 1; rst = 1; 
        din = 0; 
        en_din = 0; en_dout = 0; we = 0;
        addr_din = 0; 
        addr_dout = 0; 

        #5 rst = 0;
        //Write to RAM enabled
        en_din =1 ; we = 1;
        // Write 1 in position 0 
        addr_din = 0; din = 1;
        #5 // write 5 in position 1
        addr_din = 1; din = 2;
        #5 //Write to RAM disabled
         addr_din = 2; din = 4;
        #5 //Write to RAM disabled
        en_din = 0; we = 0;
        // Read from RAM enabled
        en_dout = 1;
        // read from position 0
        addr_dout = 0;
        #5 // read from position 1
        addr_dout = 1;
        #5 // read from position 1
        addr_dout = 2;
        #10
        $stop;
    end
endmodule
