module Counter_4_ins(
    input wire clk, rst,
    input wire en_ins,
    output reg hit_4
);
    reg [1:0] count, count_next;
    reg hit_4_next;  

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            hit_4 <= 0;
        end 
        else begin
            count <= count_next;
            hit_4 <= hit_4_next;  
        end
    end
    
    always @(en_ins, count) begin
        if (en_ins) begin 
            if (count == 3) begin
                hit_4_next = 1;    
                count_next = 0;
            end
            else begin
                count_next = count + 1;
                hit_4_next = 0;    
            end
        end
        else begin
            count_next = count;
            hit_4_next = 0;       
        end
    end
endmodule
