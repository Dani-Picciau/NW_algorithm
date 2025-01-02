module mtc_msmtc(
    input [2:0] a,     // Segnale di input A (3 bit)
    input [2:0] b,     // Segnale di input B (3 bit)
    output reg signed [3:0] result // Risultato complemento a 2 (+1 o -1, 4 bit)
);

always @(a,b) begin
    if (a == b) 
        result = 4'b0001;  // +1 in formato binario (4 bit)
    else 
        result = 4'b1111;  // -1 in formato binario (4 bit)
end
    
endmodule
