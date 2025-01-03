module fsm (
    input wire clk, rst,
    input wire end_init, calc, end_fill, ending,
    output reg en_init, en_ins, we, en_read, en_traceB, 
    output reg [1:0] state
);
    parameter init = 3'b000, read = 3'b001, fill = 3'b010, 
    traceB = 3'b011, Ending = 3'b100;
    
    reg [1:0] next_state;

    always @(posedge clk, posedge rst) begin
        if(rst) state <= init;
        else state <= next_state;
    end

    always@(end_init, calc, end_fill, ending) begin
        case(state)
            init:
                if(end_init) next_state = read;
                else next_state = init;
            read:
                if(calc) next_state = fill;
                else next_state = read;
            fill:
                if(end_fill) next_state = traceB;
                else next_state = read;
            traceB:
                if(ending) next_state = Ending;
                else next_state = traceB;
            default: next_state = init;
        endcase 
    end

    always@(state) begin
        case(state)
            init:begin
                en_init = 1'b1;
                en_ins = 1'b0;
                we = 1'b1;
                en_read = 1'b0;
                en_traceB = 1'b0;
            end
            read:begin
                en_init = 1'b0;
                en_ins = 1'b1;
                we = 1'b0;
                en_read = 1'b1;
                en_traceB = 1'b0;
            end
            fill: begin
                en_init = 1'b0;
                en_ins = 1'b0;
                we = 1'b1;
                en_read = 1'b0;
                en_traceB = 1'b0;
            end
            traceB: begin
                en_init = 1'b0;
                en_ins = 1'b0;
                we = 1'b0;
                en_read = 1'b0;
                en_traceB = 1'b1;
            end
            Ending: begin
                en_init = 1'b0;
                en_ins = 1'b0;
                we = 1'b0;
                en_read = 1'b0;
                en_traceB = 1'b0;
            end
        endcase
    end
endmodule

