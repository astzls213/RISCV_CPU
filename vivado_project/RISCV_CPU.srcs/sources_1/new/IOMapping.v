`timescale 1ns / 1ps

module IOMapping(
    // RAM
    input clk,
    input we,
    input [7:0] addr,
    input [31:0] wdata,
    input [2:0] mm,
    output [31:0] rdata,
    // IO
    input [3:0] switch,
    output reg [31:0] result
);
    // addr=0x40ʱ��switch���������
    // addr=0x80ʱд����������result
    // �����Ϊ����RAM
    wire [31:0] RAM_rdata, RAM_wdata;
    wire RAM_ce, RAM_we;
    assign RAM_ce = ~(|addr[7:6]);
    assign RAM_we = RAM_ce & we;
    RAM IOMapping_RAM(
        .clk(clk),
        .we(RAM_we),
        .mm(mm),
        .addr(addr[5:0]),
        .rdata(RAM_rdata),
        .raw_wdata(RAM_wdata)
    );

    assign rdata = addr[6] ? {28'h0, switch} : RAM_rdata;
    assign RAM_wdata = wdata;

    always @(posedge clk)
    begin
        if(we & addr[7])
            result <= wdata;
    end
endmodule
