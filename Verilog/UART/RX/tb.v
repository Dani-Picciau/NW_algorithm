`include "/c:.../"
`timescale 1fs / 1fs
module tb_uart;
    parameter DATA_BITS = 8;
    parameter STOP_TICK = 16;
    parameter BR_COUNT = 651;
    parameter BIT_PERIOD = 104166; // Full bit period matching baud rate
    
    reg clk, rst;
    reg rx;
    wire [2:0] Seq;
    wire weA, weB, enable_ram;
    wire [2:0] address_ramA, address_ramB;
    
    uart_top DUT (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .address_ramA(address_ramA),
        .address_ramB(address_ramB),
        .Seq(Seq),
        .weA(weA),
        .weB(weB),
        .enable_ram(enable_ram)
    );
    
     // Generazione del clock a 100 MHz
    always #(10 / 2) clk = ~clk;

    // Simulazione della trasmissione seriale di un byte
    task uart_send_byte(input [7:0] data);
        integer i;
        begin
            // Start bit (LOW)
            rx = 0;
            #(BIT_PERIOD);

            // Invio dati (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end

            // Stop bit (HIGH)
            rx = 1;
            #(BIT_PERIOD);
        end
    endtask

    initial begin
        // Inizializzazione segnali
        clk = 0;
        rst = 1;
        rx = 1; // Linea UART inattiva (idle = HIGH)
        
        #100; // Attendi un po'
        
        rst = 0; // Disabilita reset
        #1000;

        // Invia carattere 'A' (ASCII 0x41 = 01000001)
        uart_send_byte(8'h41);
        #BIT_PERIOD; 

        // Attendi e controlla lo stato
        #500000;
        
        // Invia un altro carattere 'B' (ASCII 0x42)
        uart_send_byte(8'h23);
        #BIT_PERIOD;
        
        // Invia un altro carattere 'B' (ASCII 0x42)
        uart_send_byte(8'h43);
        //#BIT_PERIOD;

       
        

        $stop; // Termina la simulazione
    end
endmodule