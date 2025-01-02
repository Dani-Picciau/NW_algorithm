module Direction_RAM #(
    parameter N=128,
    parameter BitAddr = $clog2(N)  
) (
    input wire clk,rst,
    input wire en_ins,we,en_traceB,
    input wire [BitAddr:0] i, j, i_t, j_t,
    input wire [2:0] symbol_in,
    output reg [2:0] symbol_out
);

    reg [2:0] ram [N*N:0]; /*the ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings
                            then each cell needs to be of 3 bits because we need them for the arrow < > \*/

    /*i think we need to add the initializzation even to ths ram for all the arrows in the first column and in tha first row
    that points to the 0*/
    always @(posedge clk, posedge rst/*,en_init,en_read,en_ins,we*/) begin
        if(rst) begin
            //something
        end
        else if(en_ins) begin
            if(we)
            begin
                ram[i+N*j] <= symbol_in;
            end
        end
        else if(en_traceB) begin
            symbol_out=ram[i_t+N*j_t];
        end
    end

 endmodule