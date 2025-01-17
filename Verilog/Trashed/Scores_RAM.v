module Scores_RAM #(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_init,en_ins,we,en_read,
    input wire [BitAddr:0] addr, i, j,
    input wire [8:0] max, data,
    output reg [8:0] diag, up, left
);
    
    reg [8:0] ram [((N+1)*(N+1))-1:0]; /*The ram needs to be 129*129 because we need 128 characters +1 of gap for both the strings then each cell needs to be of 9 bits because that's how many bits are needed to store the numbers -128 to +128 in c2*/

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            diag<=0;
            up<=0;
            left<=0;
        end
        else begin
            if(en_init && we) begin
                ram[addr] <= data; //addr+N*0 = first row
                ram[(N+1)*addr] <= data; // 0+N*addr = first column
            end
            else if(en_ins && we) ram[(j+1)+((N+1)*(i+1))] <= max; 
            else if(en_read) begin //This helps to avoid creating problems between reading and writing
                diag <= ram[j+(N+1)*i];
                left <= ram[(j+1)+(N+1)*i];
                up <= ram[j+(N+1)*(i+1)];
            end
        end
    end
endmodule