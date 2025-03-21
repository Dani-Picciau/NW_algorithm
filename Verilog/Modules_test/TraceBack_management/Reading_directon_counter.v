module Reading_direction_counter#(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1),
    parameter UP=3'b010,
    parameter LEFT=3'b100, 
    parameter DIAG=3'b001
) (
    input wire clk, rst,
    input wire [2:0] symbol,
    output reg end_c,
    output reg [BitAddr:0] i_t, j_t,
    output reg [BitAddr:0] i_t_ram, j_t_ram
);
    reg [BitAddr:0] i_nxt, j_nxt;

    reg [1:0] counter;  //Counter from 0 to 3 

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i_t <= N;
            j_t <= N;
            counter <= 0;
        end
        else begin
            if(counter == 3) begin  // Change value every 4 cycles
                i_t <= i_nxt;
                j_t <= j_nxt;
                counter <= 0;  // Counter reset
            end
            else begin
                counter <= counter + 1;  // Counter increment
            end
        end
    end

    //pt.2

    always @(i_t, j_t, symbol) begin
    
        i_nxt = i_t;
        j_nxt = j_t;
        end_c = 0;
        
        if(i_t!=0 && j_t!=0) begin
            case (symbol)
                UP: begin
                    i_nxt = i_t - 1;
                    j_nxt = j_t;
                end
                LEFT: begin
                    i_nxt = i_t;
                    j_nxt = j_t - 1;
                end
                DIAG: begin
                    i_nxt = i_t - 1;
                    j_nxt = j_t - 1;
                end
                default: begin
                    i_nxt = i_t;
                    j_nxt = j_t;
                end
            endcase
        end
        else begin
            if(i_t == 0 && j_t == 0) begin
                end_c = 1;
            end
            else begin
                if(i_t == 0 && j_t != 0 && symbol == LEFT) begin
                    i_nxt = i_t;
                    j_nxt = j_t - 1;
                end 
                else if(i_t != 0 && j_t == 0 && symbol == UP) begin
                    i_nxt = i_t - 1;
                    j_nxt = j_t;
                end
            end
        end
    end

    //pt.3

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i_t_ram <= N-1;
            j_t_ram <= N-1;
        end
        else if(i_t == 0 && j_t != 0) begin
            i_t_ram <= 0;
            j_t_ram <= j_t - 1;
        end 
        else if(i_t != 0 && j_t == 0) begin
            i_t_ram <= i_t - 1;
            j_t_ram <= 0;
        end 
        else if(i_t == 0 && j_t == 0) begin
            i_t_ram <= 0;
            j_t_ram <= 0;
        end
        else begin
            i_t_ram <= i_t - 1;
            j_t_ram <= j_t - 1;
        end
    end
    
    //end
endmodule

