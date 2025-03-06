module FSM(
    input wire clk, rst,
    input wire ready,
    input wire end_init,
    input wire calculated,
    input wire end_filling,
    input wire end_traceB,
    input wire hit_4,
    
    output reg we,
    output reg en_init,
    output reg en_ins,
    output reg en_read,
    output reg en_traceB,
    output reg change_index,
    output reg [2:0] state
);
    reg [2:0] state_next;
    parameter IDLE=3'b000, INIT=3'b001, READ=3'b010, CHANGE=3'b011, FILLING=3'b100, TRACE_B=3'b101;
    
    always@(posedge clk, posedge rst)begin
        if(rst) state <= IDLE;
        else state <= state_next;
    end
    
    always@(state, ready, end_init, calculated, hit_4, end_filling, end_traceB) begin
        case (state)
            IDLE: begin
                if(ready) state_next <= INIT;
                else state_next <= IDLE;
            end
            INIT: begin
                if(end_init) state_next <= READ;
                else state_next <= INIT;
            end
           READ: begin
                if(calculated) state_next <= FILLING;
                else state_next <= READ;
            end
            CHANGE: begin
                state_next <= READ;
            end
            FILLING: begin
                if(!hit_4)state_next <= FILLING;
                else begin
                    if(end_filling) state_next <= TRACE_B;
                    else state_next <= CHANGE;
                end
            end
            TRACE_B: begin
                if(end_traceB) state_next <= IDLE;
                else state_next <= TRACE_B;
            end
            default: state_next <= IDLE;
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
                change_index <= 0;
            end
            INIT: begin
                we <= 1;
                en_init <= 1;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 0;
                change_index <= 0;
            end
            READ: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 1;
                en_traceB <= 0;
                change_index <= 0;
            end
            CHANGE: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 1;
                en_traceB <= 0;
                change_index <= 1;
            end
            FILLING: begin
                we <= 1;
                en_init <= 0;
                en_ins <= 1;
                en_read <= 0;
                en_traceB <= 0;
                change_index <= 0;
            end
            TRACE_B: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 1;
                change_index <= 0;
            end
            default: begin
                we <= 0;
                en_init <= 0;
                en_ins <= 0;
                en_read <= 0;
                en_traceB <= 0;
                change_index <= 0;
            end
        endcase
    end

    //end
endmodule
