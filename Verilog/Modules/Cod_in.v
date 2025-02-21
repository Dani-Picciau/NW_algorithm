module cod_in #(
    parameter N=8
)(
	input wire clk, rst,
	input wire [N-1:0] Rxdata_out, //data out from the UART
	output reg [2:0] char //data codified for our system
);
	
	always @(posedge clk, posedge rst) begin
        if(rst) char = 3'b000;
        else begin 
            case (Rxdata_out)
                8'h47: char = 3'b001; //G
                8'h43: char = 3'b110; //C
                8'h41: char = 3'b100; //A
                8'h54: char = 3'b011;  //T
                default: char = 3'b000;
		    endcase
        end
    end
    //
endmodule