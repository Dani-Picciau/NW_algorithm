`include "/c:.../Converter.v"

module TB_Converter;

    // Dichiarazione dei segnali di input e output
    reg clk;
    reg rst;
    reg start;
    wire [2:0] rom_data;
    wire done;

    // Istanziazione del modulo Converter
    Converter test (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rom_data(rom_data),
        .done(done)
    );

    // Generatore di clock
    always #5 clk = ~clk;  // Clock con periodo di 10 unità di tempo
   
    // Inizializzazione dei segnali
    initial begin
        // Inizializzazione dei segnali
        clk = 0; rst = 1; start = 0;
        #10
        //Start reading
        rst=0; start=1;
        #50
        $stop;
    end
endmodule