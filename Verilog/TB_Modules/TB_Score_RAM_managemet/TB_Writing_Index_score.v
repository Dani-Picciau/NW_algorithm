`include "/c:.../Writing_index_score.v"

module TB_wr_indx_S();

    parameter N = 5;
    parameter BitAddr = $clog2(N);
    parameter addr_lenght = (((N+1)*(N+1))-1);
    
     reg clk, rst;
     reg en_ins, en_init,hit;
     reg [BitAddr:0] i, j, addr_init;
     reg [8:0] max, data_init;
     wire [addr_lenght:0] addr_out;
     wire [8:0] data_out;

wr_indx indx(
    .clk(clk),
    .rst(rst),
    .en_ins(en_ins),
    .en_init(en_init),
    .hit(hit),
    .i(i),
    .j(j),
    .addr_init(addr_init),
    .max(max),
    .data_init(data_init),
    .addr_out(addr_out),
    .data_out(data_out)
);

always #2 clk=!clk;
initial begin 
rst=1;
#4 rst=0;
clk=0;
en_init=1;
en_ins=0;
i=000;
j=000;
addr_init=011;
max=000000000;
data_init=001010110;
hit=0;
#8 hit=1;
#8 hit=0;
en_init=0;
en_ins=1;
i=010;
j=101;
addr_init=000;
max=010101100;
data_init=00000000;
end




endmodule