`timescale 1ns / 1ps

module RegStack(
    input clk,
    input we,               // дʹ�� �ߵ�ƽ��Ч
    input [4:0] raddr1,
    output [31:0] rdata1,
    input [4:0] raddr2,
    output [31:0] rdata2,
    input [4:0] waddr,
    input [31:0] wdata
);
    /* 
     * RISC-V �Ĵ����� ��Ŀ��32 ˫�˿ڶ� ������д
     */
    
    reg[31:0] regs[1:31];
    
    assign rdata1 = (raddr1 == 5'b00000) ? 32'b0 : regs[raddr1];
    assign rdata2 = (raddr2 == 5'b00000) ? 32'b0 : regs[raddr2];
    
    always @(posedge clk)
        if(we)
            if(waddr != 5'b00000)
                regs[waddr] <= wdata;

    // ����
    initial begin
        $monitor($time, , "Reg->waddr => %d", waddr);
        $monitor($time, , "Reg->wdata => 0x%8h", wdata);
    end
endmodule
