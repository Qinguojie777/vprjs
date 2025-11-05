module if(
    input   clk,
    input   rst_n,
    output  [`InstAddrBus-1:0]  pc
);
reg [`InstAddrBus-1:0] pcreg;
always@(posedge clk or negedge rst_n)begin
    if(rst_n == `RstEnable)begin
        pcreg <= `InstAddrBus'h0;
    end
    else begin
        pcreg <= pcreg + 'h4;
    end
end
assign  pc = pcreg;
endmodule
