module regfile(
    input   clk,
    input   rst_n,
    
    input   we,
    input   [`RegAddrBus-1:0]   waddr,
    input   [`RegDataBus-1:0]   wdata,

    input   re1,
    input   [`RegAddrBus-1:0]   raddr1,
    output  [`RegDataBus-1:0]   rdata1,
    input   re2,
    input   [`RegAddrBus-1:0]   raddr2,
    output  [`RegDataBus-1:0]   rdata2
);
reg [`RegDataBus-1:0]   regmem[0:RegDepth-1];

integer i;
always@(*)begin:regmem0  //reg0 is always zero
    regmem[0] = `DataZero;
end
always@(posedge clk or negedge rst_n)begin
    if(rst_n == `RstDisable)begin
        if((we == `WriteEnable) && (|waddr))begin
            regmem[waddr] <= wdata;
        end
    end
end

reg [`RegDataBus-1:0] rdata1_r0,rdata2_r0;
always@(*)begin
    
end

endmodule
