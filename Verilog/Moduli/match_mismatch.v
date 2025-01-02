module mtc_msmtc(
    input [2:0] a,     // Segnale di input A (3 bit)
    input [2:0] b,     // Segnale di input B (3 bit)
    output reg  result // se 1 match se 0 mismatch
);

always @(a,b) begin
    if (a == b) 
        result = 1'b1;  //match
    else 
        result = 1'b0;  //mismatch
end
    
endmodule
