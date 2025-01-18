module Output_manager (
    input wire clk, rst,               // Clock and reset signals
    input wire en_read,                // Enable signal for reading data
    input wire [1:0] count,            // Counter to address the buffer
    input wire [8:0] ram_data,         // Input data from RAM
    input wire signal,                 //
    output reg [8:0] diag, left, up    // Outputs for diagonal, left, and up data
);
    reg [8:0] buffer [2:0]; // Buffer to store data temporarily

    // Process to update the buffer and the "en_read" signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs and ready signal to 0
            diag <= 0;
            up <= 0;
            left <= 0;
        end 
        else if (en_read) buffer[count] <= ram_data;
    end
    
    always @(posedge clk) begin
        if (signal) begin
            // Assign the buffered data to the outputs
            diag <= buffer[0];  // Output the first buffer value to "diag"
            up <= buffer[1];    // Output the second buffer value to "up"
            left <= buffer[2];  // Output the third buffer value to "left"
        end
        else begin
            // If not ready, reset the outputs to 255
            diag <= 255;
            up <= 255;
            left <= 255;
        end
    end
endmodule