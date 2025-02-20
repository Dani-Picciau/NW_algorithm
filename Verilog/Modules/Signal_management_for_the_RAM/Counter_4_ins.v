module Counter_4_ins(
    input wire clk, rst,
    input wire en_ins,
    output reg hit_4
);
    reg [1:0] count, count_next;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            count_next <= 0;
            hit_4 <= 0;
        end 
        else begin
            count <= count_next;
        end
    end
    
    always @(en_ins, count) begin
        if (en_ins) begin 
            if (count == 3) begin
                hit_4 = 1;
                count_next = 0;
            end
            else begin
                count_next = count + 1;
                hit_4 = 0;
            end
        end
        else begin
            count_next = count;
            hit_4 = 0;
        end
    end
    
    //end
endmodule