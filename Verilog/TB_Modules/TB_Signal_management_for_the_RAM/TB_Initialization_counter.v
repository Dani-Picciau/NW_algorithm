module Tbiniz();
    reg clk, rst;
    reg en_init;
    wire [7:0] addr;
    wire signed [8:0] data;
    wire end_init;

    // Istanza del modulo iniz
    iniz init(
        .clk(clk),
        .rst(rst),
        .en_init(en_init),
        .addr(addr),
        .data(data),
        .end_init(end_init)
    );

    // Generazione del clock
    always #0.5 clk = !clk;

    // Stimolo
    initial begin
        // Inizializzazione
        
        rst = 1;
        

        // Reset attivo
        #1 rst = 0;
        clk=0;
         en_init = 1;
        #200 en_init = 0;

    end
endmodule
