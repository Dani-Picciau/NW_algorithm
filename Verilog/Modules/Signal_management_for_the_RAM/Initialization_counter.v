module Initialization_counter # (
    parameter gap_score = -2,
    parameter N = 128,
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_init,
    input wire hit,
    output reg [7:0] addr,
    output reg signed [8:0] data,
    output reg end_init 
); 
    reg [BitAddr:0] addr_next; //0
    reg [8:0] data_next; //1

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            addr <= 0;
            data <= 0;
        end
        else begin
            data <= data_next;
            addr <= addr_next;
        end
    end

    always@(posedge clk, posedge hit)begin
        if(addr == N) begin
            end_init <= 1;
            addr_next <= addr;
        end
        else begin
            end_init <= 0;
            if(en_init) begin
                if(!hit) begin
                    data_next = data + gap_score;
                    addr_next = addr + 1;
                end 
                else begin
                    data_next <= data;
                    addr_next <= addr;
                end
            end
            else begin
                data_next <= data;
                addr_next <= addr;
            end
        end
    end

    //end
endmodule
