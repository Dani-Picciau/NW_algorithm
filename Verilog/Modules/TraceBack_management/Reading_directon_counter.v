module RD_Counter#(
    parameter N=128, 
    parameter BitAddr = $clog2(N+1)
) (
    input wire clk,rst,
    input wire en_traceB,
    input wire [2:0] symbol,
    output reg end_c,
    output reg [BitAddr:0] i_t, j_t
);
    reg [BitAddr:0] i_nxt, j_nxt;
    parameter [2:0] UP=3'b010, LEFT=3'b100, DIAG=3'b001;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            i_t <= N+1;
            j_t <= N+1;
        end
        else begin
            i_t <= i_nxt;
            j_t <= j_nxt;
        end
    end

    always @(posedge clk) begin
        if(i_t!=0 && j_t!=0)begin
            end_c=0;
            case (symbol)
                UP: begin
                    i_nxt <= i_t-1;
                    j_nxt <= j_t;
                end
                LEFT: begin
                    i_nxt <= i_t;
                    j_nxt <= j_t-1;
                end
                DIAG: begin
                    i_nxt <= i_t-1;
                    j_nxt <= j_t-1;
                end
                default: begin
                    i_nxt <= i_t;
                    j_nxt <= j_t;
                end
            endcase
        end
        else begin
            if(i_t==0 && j_t==0) end_c=1;
            else begin
                end_c=0;
                if(i_t==0 && j_t!=0 && symbol==LEFT) begin
                    i_nxt <= i_t;
                    j_nxt <= j_t-1;
                end else if(i_t!=0 && j_t==0 && symbol==UP) begin
                    i_nxt <= i_t-1;
                    j_nxt <= j_t;
                end else begin
                    i_nxt <= i_t;
                    j_nxt <= j_t;
                end
           end
        end
    end
endmodule