`include "/c:.../Reading_index.v"

module TB_Reading_index;

  //Parameters
    parameter N = 5;
    parameter BitAddr = $clog2(N+1);
    parameter addr_lenght = $clog2(((N+1)*(N+1)));

    //Signal input 
    reg clk, rst, en_read;
    reg[1:0] count;
    reg change_index;
    reg [BitAddr:0] i, j;

    //Signal output
    wire [addr_lenght-1:0] addr;

    //Instantiation of the Reading_index module
    Reading_index_score #(
        .N(N),
        .BitAddr(BitAddr),
        .addr_lenght(addr_lenght)
    ) test (
        .clk(clk),
        .rst(rst),
        .en_read(en_read),
        .change_index(change_index),
        .count(count),
        .i(i),
        .j(j),
        .addr(addr)
    );

    // Clock generation
    always #0.5 clk = ~clk;

    initial begin
        // Initialization of signals
        clk=0; rst=1; en_read=0; count=0 ;change_index=0; i=0; j=0;
    
        // Abilitation en_read
        #5.5 rst=0; en_read=1;

      
           i=0; j=0; 
           count=2'b00; // Expected value: 130
        #2 count=2'b01; // Expected value: 131
        #2 count=2'b10; // Expected value: 259
        #2 count=2'b11; // Expected value: 259
        #4  change_index=1;

   
        #5 i=1; j=1; 
           count=2'b00; // Expected value: 1
        #2 count=2'b01; // Expected value: 2
        #2 count=2'b10; // Expected value: 130
           
      
        #5 i=1; j=0; change_index=0;
           count=2'b00; // Expected value: 0
        #2 count=2'b01; // Expected value: 1
        #2 count=2'b10; // Expected value: 129
        


      

        
        
        
        #20;
        $stop;
    end
endmodule
