module Output_manager (
    input wire clk, rst,               // Clock and reset signals
    input wire en_read,                // Enable signal for reading data
    input wire [1:0] count,            // Counter to address the buffer
    input wire [8:0] ram_data,         // Input data from RAM
    output reg [8:0] diag, left, up    // Outputs for diagonal, left, and up data
);
    reg [8:0] buffer [2:0];            // Buffer to store data temporarily
    reg ready;                         // Signal to indicate when data is ready for output

    // Process to update the buffer and the "ready" signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs and ready signal to 0
            diag <= 0;
            left <= 0;
            up <= 0;
            ready <= 0;
        end 
        else if (en_read) begin
            // Store the incoming data into the buffer at the address specified by "count"
            buffer[count] <= ram_data;

            // Set the "ready" signal high when all the buffer data is written (count == 2'b10)
            if (count == 2'b10) ready <= 1;
            else ready <= 0;
        end
    end

    // Process to update the outputs based on the "ready" signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs to 0
            diag <= 0;
            left <= 0;
            up <= 0;
        end
        else if (ready) begin
            // Assign the buffered data to the outputs
            diag <= buffer[0];        // Output the first buffer value to "diag"
            left <= buffer[1];        // Output the second buffer value to "left"
            up <= buffer[2];          // Output the third buffer value to "up"
        end
        else begin
            // If not ready, reset the outputs to 0
            diag <= 0;
            left <= 0;
            up <= 0;
        end
    end
endmodule

/*
    {
        I encountered an issue with my Verilog module, specifically with the Output_manager. The problem was that the output signals diag, left, and up were not behaving as expected. When the count signal reached 2'b10, the module was supposed to assign the values from the buffer to these outputs. However, I noticed that sometimes the outputs were incorrect or inconsistent.

        After analyzing the waveform, I realized that the issue was caused by the timing of how the buffer is updated and then immediately read. In the same clock cycle where count equals 2'b10, the buffer[count] is updated with new data, but the outputs are also being assigned values from the buffer. This creates a race condition because the buffer might not yet hold the correct values when the outputs are assigned.

        To resolve this, I introduced a one-clock-cycle delay using a pipeline approach. I added a signal called ready to indicate when the data in the buffer is ready to be used for the outputs. Here's how I fixed it:

        1.  separated the logic for updating the buffer from the logic that assigns values to diag, left, and up. The buffer is updated as usual when en_read is high.

        2. When count reaches 2'b10, I set the ready signal to 1, indicating that in the next clock cycle, the data in the buffer can be safely used.

        3. In a separate always block, I use the ready signal to assign values from the buffer to the outputs, ensuring the buffer values are stable and correct.
    }  
*/
