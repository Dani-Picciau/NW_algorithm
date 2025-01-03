module iniz #(
    parameter gap = -1
) (
    input wire clk,rst,
    input wire en_init,
    output reg [7:0] addr,
    output reg signed [8:0] data,
    output reg end_init
); //valore di gap -1 
    
    reg [7:0]addres=9'b000000000;
    reg [8:0]dato=9'b000000001;

    //inizializzazione registro dati
    always @(posedge clk, posedge rst) begin
        if(rst) data <= 0;
        else data <= dato;
    end

    //inizializatione registro inidirizzi
    always @(posedge clk, posedge rst) begin
        if(rst) addr <= 0;
        else addr <= addres;
    end

    //scrittra prima riga della matrice con i punteggi di gap, per la colonna verrà gestita direttamente dentro la ram
    always@(clk, en_init, dato, addres)begin
        if(en_init==1)begin 
            dato = data + gap;
            addres = addr + 1;
            end_init = 0;
        end
        else end_init=1; 
    end
endmodule
