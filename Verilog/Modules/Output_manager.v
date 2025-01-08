module Output_manager (
    input wire clk,
    input wire rst,
    input wire en_read,
    input wire [8:0] ram_data,
    output reg [8:0] diag, up, left
);

    reg [1:0] state, state_next;
    reg [8:0] buffer [2:0];

    always@(posedge clk, posedge rst) begin
        if (rst) state<= 0;
        else state <= state_next;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            diag <= 0;
            up <= 0;
            left <= 0;
        end 
        else if (en_read) begin
            buffer[state] <= ram_data;
            state_next <= state + 1;

            if (state == 2'b10) begin
                diag <= buffer[0];
                up <= buffer[1];
                left <= buffer[2];
                state <= 2'b00; // Reset state after collecting all data
            end
        end
    end
endmodule