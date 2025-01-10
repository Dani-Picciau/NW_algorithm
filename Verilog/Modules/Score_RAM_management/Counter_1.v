module Counter_1 (
    input wire clk, rst,
    input wire en_init,
    output reg hit
);
    reg hit_n; 

    always @(posedge clk, posedge rst) begin
        if(rst) hit <= 0;
        else hit<=hit_n;
    end

    always @(posedge clk ) begin
        if(en_init) begin
            if(!hit) hit_n <= hit +1;
            else hit_n <=0;
        end
        else hit_n<=0;
    end
endmodule