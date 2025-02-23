module cod_out #(
    parameter N=8
)(
	input wire clk, rst,
	input wire [2:0] char, //data out from our system, with our codify
	output reg [N-1:0] Txdata_in //data converded for the UART
);
	
	always @(posedge clk, posedge rst) begin
        if(rst) Txdata_in = 8'h58; //X
        else begin 
            case(char)
                3'b001: Txdata_in = 8'h47; //G
                3'b110: Txdata_in = 8'h43; //C
                3'b100: Txdata_in = 8'h41; //A
                3'b011: Txdata_in = 8'h54; //T
                3'b111: Txdata_in = 8'h2D; //-
                default: Txdata_in = 8'h58; //X 
            endcase
        end
    end
    //
endmodule