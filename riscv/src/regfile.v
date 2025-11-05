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
reg [`RegDataBus-1:0] rdata1_r0,rdata2_r0;

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


always@(*)begin
    if (rst_n == `RstEnable) begin
        rdata1_r0 = `DataZero;
    end
    else if (re1) begin
        if (we && (raddr1 == waddr)) begin
            rdata1_r0 = wdata;
        end
        else begin
            rdata1_r0 = regmem[raddr1];
        end
    end
    else begin
        rdata1_r0 = `DataZero;
    end
end
always@(*)begin
    if (rst_n == `RstEnable) begin
        rdata1_r0 = `DataZero;
    end
    else if (re2) begin
        if (we && (raddr2 == waddr)) begin
            rdata2_r0 = wdata;
        end
        else begin
            rdata2_r0 = regmem[raddr2];
        end
    end
    else begin
        rdata2_r0 = `DataZero;
    end
end

assign  rdata1 = rdata1_r0;
assign  rdata2 = rdata2_r0;

endmodule
