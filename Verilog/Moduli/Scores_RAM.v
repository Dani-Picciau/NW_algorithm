module Scores_RAM #(
    parameter N=128,
    parameter BitAddr = $clog2(N)  
) (
    input wire clk,rst,
    input wire en_init,en_ins_read,we,
    input wire [BitAddr:0] addr, i_in, j_in,
    input wire [8:0] max, data,
    output reg [8:0] diag, up, left
);

    reg [8:0] ram [N*N:0]; /*the ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings
                            then each cell needs to be of 9 bits because that's how many bits are needed to store the numbers -128 to +128 in c2*/

    wire [BitAddr:0] i,j; 
    assign i=i_in+1; // because in the "matrix" we have a gap cell before the sequence
    assign j=j_in+1; // ''

    always @(posedge clk, posedge rst/*,en_init,en_read,en_ins,we*/) begin
        if(rst) begin
            diag<=0;
            up<=0;
            left<=0;
        end
        else begin
            if(en_init) begin
                if(we)
                    begin
                    ram[addr] <= data; //addr+N*0 = first row
                    ram[N*addr] <= data; // 0+N*addr = first column
                    end
            end
            else if(en_ins_read) begin
                if(we)
                    begin
                        ram[i+N*j] <= max;
                    end
                else
                    begin
                        diag<=ram[(i-1)+N*(j-1)];
                        up<=ram[(i-1)+N*j];
                        left<=ram[i+N*(j-1)];
                    end
            end
        end
    end

 endmodule