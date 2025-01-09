module Output_manager (
    input wire clk, rst,
    input wire en_read,
    input wire [8:0] ram_data,
    output reg [8:0] diag, up, left,
    output reg [1:0] state
);

    reg [1:0] state_next;
    reg [8:0] buffer [2:0];

    // Register to count the number of clock cycles
    always@(posedge clk, posedge rst) begin
        if (rst) state <= 0;
        else state <= state_next;
    end

    // Register for the data
    always @(posedge clk, posedge rst) begin
        
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            diag <= 0;
            up <= 0;
            left <= 0;
        end 
        else if(en_read) begin
            buffer[state] <= ram_data;
            state_next <= state + 1;
            if(state == 2'b10) begin
                diag <= buffer[0];
                up <= buffer[1];
                left <= buffer[2];
                state_next <= 2'b00; // Reset state after collecting all data
            end
            else begin
                diag <= 0;
                up <= 0;
                left <= 0;
            end
        end
    end
endmodule