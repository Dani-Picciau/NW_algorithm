module Converter #(
    parameter N=128                // Parameter for memory size 
) (
    input clk, rst,                // Clock and reset signals
    input start,                   // Signal to start the conversion process
    output reg [2:0] rom_data,     // Data read from the memory (ROM-like behavior)
    output reg done                // Flag indicating that the conversion is complete
);
    reg [2:0] memory [N-1:0];      // Memory array with N entries, each 3 bits wide
    reg [6:0] index, index_next;   // Index to traverse the memory
    reg [7:0] char;                // Character read from the file (ASCII encoded)
    integer file;                  // File descriptor for the input file

    // Initialize and open the file when the simulation starts
    initial begin
        file = $fopen("C:/Esercizi verilog laboratorio/TestBlocks/TestBlocks/file.txt", "r"); 
        if (file == 0) begin
            $display("Error: unable to open the file."); 
            $finish;                                  
        end
    end

    // Sequential reading of characters from the file
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            index <= 0;               
            done <= 0;                 
        end 
        else if (start && !done) begin
            char = $fgetc(file); // Read a character from the file
            case (char)
                "G": memory[index] = 3'b001; // Map 'G' to binary 001
                "T": memory[index] = 3'b010; // Map 'T' to binary 010
                "A": memory[index] = 3'b011; // Map 'A' to binary 011
                "C": memory[index] = 3'b100; // Map 'C' to binary 100
                default: memory[index] = 3'bxxx; // Assign invalid value for unexpected characters
            endcase
            index_next <= index + 1; 

            // Check if the file reading is complete
            if ($feof(file) || index == 128) begin
                $fclose(file);         
                done <= 1; // Set the completion flag
            end
        end
    end

    // Logic to send data to the ROM-like output during reading
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rom_data <= 3'b000;       
        end else if (!done) rom_data <= memory[index]; 
        else rom_data <= 3'b000;        
    end
endmodule
