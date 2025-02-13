module Match_mismatch(
    input wire [2:0] a,     
    input wire [2:0] b,     
    output reg  value
);
    always @(a,b) begin
        if (a == b) value <= 1'b1; 
        else value <= 1'b0;  
    end
endmodule

// non so se ha senso perché con il rst lo metto a 0 e poi avendo aggiunto un registro ci sarà un clk di ritardo in più


// module Match_mismatch(
//     input wire clk, rst, en_read,
//     input wire [2:0] a,     
//     input wire [2:0] b,     
//     output reg  value
// );
//     reg value_next;

//     always @(posedge clk ) begin
//         if(rst) value <= 0;
//         else value <= value_next;
//     end

//     always @(a,b) begin
//         if (en_read) begin
//             if (a == b) value_next <= 1'b1; 
//             else value_next <= 1'b0;
//         end
//         else value_next <= value;  
//     end

// 
// endmodule
