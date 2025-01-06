module RD_Counter#(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_traceB,
    input wire [2:0] symbol,
    output reg end_c,
    output reg [BitAddr:0] i, j
);
    reg [BitAddr:0] i_nxt, j_nxt;
    parameter [2:0] UP=3'b010, LEFT=3'b100, DIAG=3'b001;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i <= N+1;
            j <= N+1;
        end
        else begin
            i <= i_nxt;
            j <= j_nxt;
        end
    end

    always @(posedge clk) begin
        if(i!=0 && j!=0)begin
            end_c=0;
            case (symbol)
                UP: begin
                    i_nxt <= i-1;
                    j_nxt <= j;
                end
                LEFT: begin
                    i_nxt <= i;
                    j_nxt <= j-1;
                end
                DIAG: begin
                    i_nxt <= i-1;
                    j_nxt <= j-1;
                end
                default: begin
                    i_nxt <= i;
                    j_nxt <= j;
                end
            endcase
        end
        else begin
            if(i==0 && j==0) end_c=1;
            else begin
                end_c=0;
                if(i==0 && j!=0 && symbol==LEFT) begin
                    i_nxt <= i;
                    j_nxt <= j-1;
                end else if(i!=0 && j==0 && symbol==UP) begin
                    i_nxt <= i-1;
                    j_nxt <= j;
                end else begin
                    i_nxt <= i;
                    j_nxt <= j;
                end
           end
        end
    end
endmodule