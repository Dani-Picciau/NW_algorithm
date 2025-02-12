module Reading_direction_counter#(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk, rst,
    input wire en_traceB,
    input wire [2:0] symbol,
    output reg end_c,
    output reg [BitAddr:0] i_t, j_t,
    output reg [BitAddr:0] i_t_ram, j_t_ram
);
    reg [BitAddr:0] i_nxt, j_nxt;
    parameter [2:0] UP=3'b010, LEFT=3'b100, DIAG=3'b001;

    reg [1:0] counter;  // Contatore da 0 a 3 (2 bit sono sufficienti)

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i_t <= N-1;
            j_t <= N-1;
        end
        else begin
            if(counter == 3) begin  // Cambia valore ogni 4 cicli
                i_t <= i_nxt;
                j_t <= j_nxt;
                counter <= 0;  // Reset del contatore
            end
            else begin
                counter <= counter + 1;  // Incrementa contatore
            end
        end
    end

    always @(*) begin
        if(i_t!=0 && j_t!=0) begin
            end_c = 0;
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
            if(i_t == 0 && j_t == 0) 
                end_c = 1;
            else begin
                end_c = 0;
                if(i_t == 0 && j_t != 0 && symbol == LEFT) begin
                    i_nxt = i_t;
                    j_nxt = j_t - 1;
                end 
                else if(i_t != 0 && j_t == 0 && symbol == UP) begin
                    i_nxt = i_t - 1;
                    j_nxt = j_t;
                end 
                else begin
                    i_nxt = i_t;
                    j_nxt = j_t;
                end
            end
        end
    end

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i_t_ram = {BitAddr{1'bz}};
            j_t_ram = {BitAddr{1'bz}};
        end
        else if(i_t == 0 && j_t == 0) begin
            i_t_ram = {BitAddr{1'bz}};
            j_t_ram = {BitAddr{1'bz}};
        end
        else begin
            i_t_ram = i_t - 1;
            j_t_ram = j_t - 1;
        end
    end
endmodule