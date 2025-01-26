module Counter_1_dir (
    input wire clk, rst,
    input wire en_init,
    output reg hit
);
    reg hit_n; 

    always @(posedge clk, posedge rst) begin
        if(rst) hit <= 0;
        else hit <= hit_n;
    end

    always @(posedge clk) begin
        if(en_init) begin
            if(!hit) hit_n <= hit +1;
            else hit_n <=0;
        end
        else hit_n<=0;
    end
endmodule

/*
    {
        The hit signal updates every 2 clock cicles.
        -> When hit = 0 Writing_index_score send addr_w with the same signal (addr_w = addr) from the  initial_count block: addr_w rappresent the index for the first row.
        -> When hit = 1 Writing_index_score send addr_w = addr * (N + 1): addr_w rappresent the index for the first column.
    }
*/