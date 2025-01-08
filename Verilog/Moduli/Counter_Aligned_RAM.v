module Counter_Aligned #(
    parameter MAX=128 
)(
    input wire  clk,rst, 
    input wire en_traceB,
    output wire [$clog2(MAX):0] address // vale sia per i che per j 
);
    reg [$clog2(MAX):0] cnt,cnt_nxt; 

    always@(posedge clk, posedge rst) begin
        if(rst == 1'b1) cnt <= MAX; 
        else cnt <= cnt_nxt; 
    end

    always@(posedge clk) begin
        if(en_traceB == 1'b1 && cnt >{$clog2(MAX){1'b0}}) cnt_nxt=cnt-1;
        else cnt_nxt=cnt;
    end

    assign address = cnt; 
endmodule