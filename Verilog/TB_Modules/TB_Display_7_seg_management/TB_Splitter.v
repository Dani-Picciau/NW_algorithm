`include "/c:.../Splitter.v"

module TB_Splitter;
    reg [8:0] Percentage;  
    wire [4:0] Tens;
    wire [3:0] Units;    
    
    Splitter split (
        .Percentage(Percentage),
        .Tens(Tens),
        .Units(Units)
    );
    
   initial begin
            Percentage=49; 
        #5  Percentage=50; 
        #5  Percentage=0; 
        #5  Percentage=100; 
        #5  Percentage=75; 
        #5  Percentage=7; 
        #5
        $stop;
    end
endmodule