module Output_manager (
    input wire clk, rst,
    input wire en_read,
    input wire [1:0] count,
    input wire signed [8:0] ram_data,
    input wire signal,
    output reg signed [8:0] diag, left, up
);
    reg signed [8:0] buffer [2:0];
    
    always @(posedge clk) begin
        if (en_read) begin
            buffer[count] <= ram_data;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            diag <= 0;
            up <= 0;
            left <= 0;
        end
        else begin
            if (signal) begin
                diag <= buffer[0];
                up <= buffer[1];
                left <= buffer[2];
            end
            else begin
                diag <= 255;
                up <= 255;
                left <= 255;
            end
        end
    end
endmodule
