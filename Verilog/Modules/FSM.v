module FSM(
    input wire clk, rst,
    input wire ready,
    input wire end_init,
    input wire calculated,
    input wire signal,
    input wire end_filling,
    input wire end_traceB,
    
    output reg we,
    output reg en_init,
    output reg en_ins,
    output reg en_read,
    output reg en_traceB,
    output reg change_index,
    output reg [2:0] state
);
    reg [2:0] state_next;
    parameter IDLE=3'b000, INIT=3'b001, READ=3'b010, FILLING=3'b011, TRACE_B=3'b100;
    always@(posedge clk, posedge rst)begin
        if(rst) state <= IDLE;
        else state <= state_next;
    end
    
    always@(state, ready, end_init, calculated, signal, end_filling, end_traceB) begin
        case (state)
            IDLE: begin
                if(ready) begin
                    state_next <= INIT;
                    change_index <= 0;
                end
                else begin
                    state_next <= IDLE;
                    change_index <= 0;
                end
            end
            INIT: begin
                if(end_init) begin
                    state_next <= READ;
                    change_index <= 0;
                end
                else begin
                    state_next <= INIT;
                    change_index <= 0;
                end
            end
            READ: begin
                if(calculated && signal) begin 
                    state_next <= FILLING;
                    change_index <= 0;
                end
                else begin
                    state_next <= READ;
                    change_index <= 0;
                end
            end
            FILLING: begin
                if(end_filling) begin
                    state_next <= TRACE_B;
                    change_index <= 0;
                end
                else begin
                    state_next <= READ;
                    change_index <= 1;
                end
            end
            TRACE_B: begin
                if(end_filling) begin
                    state_next <= IDLE;
                    change_index <= 0;
                end
                else begin 
                    state_next <= TRACE_B;
                    change_index <= 0;
                end
            end
            default: begin
                state_next <= IDLE;
                change_index <= 0;
            end
        endcase
    end

    always@(state) begin
        case (state)
            IDLE: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 0;
            end
            INIT: begin
                we <= 1;
                en_init <= 1;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 0;
            end
            READ: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 1;
                en_traceB <= 0;
            end
            FILLING: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 1;
                en_read <= 0;
                en_traceB <= 0;
            end
            TRACE_B: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 1;
            end
            default: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 0;
            end
        endcase
    end

    //end
endmodule