`include "/c:.../Reading_direction_Counter.v"

module TB_RD_Counter ();   // Parametri
    parameter N = 4;
    parameter BitAddr = $clog2(N+1);

    // Segnali di input
    reg clk;
    reg rst;
    reg [2:0] symbol;

    // Segnali di output
    wire end_c;
    wire [BitAddr:0] i;
    wire [BitAddr:0] j;

    // Istanza del modulo Reading_direction_counter
    RD_Counter #(
        .N(N), 
        .BitAddr(BitAddr)
    ) RDC (
        .clk(clk),
        .rst(rst),
        .symbol(symbol),
        .end_c(end_c),
        .i(i),
        .j(j)
    );

    // Generazione del clock
    always #1 clk = ~clk;

    initial begin
        // Inizializzazione dei segnali
        clk = 1;
        rst = 1;
        symbol = 3'b000;

        // Reset
        #5;
        rst = 0;

        // Test UP
        symbol = 3'b010; // UP
        #4;

        // Test LEFT
        symbol = 3'b100; // LEFT
        #4;

        // Test DIAG
        symbol = 3'b001; // DIAG
        #4;
        
        // Test UP
        symbol = 3'b010; // UP
        #4;

        // Test LEFT
        symbol = 3'b100; // LEFT
        #4;

        // Test DIAG
        symbol = 3'b001; // DIAG
        #4;
        
        // Test UP
        symbol = 3'b010; // UP
        #4;

        // Test LEFT
        symbol = 3'b100; // LEFT
        #4;

        // Test DIAG
        symbol = 3'b001; // DIAG
        #4;
        
        // Fine del test
        #20;
        $stop;
    end

endmodule
