`timescale 1ns / 1ps

module PC(
    input clk,
    input rst,
    input [31:0] next,
    output reg [31:0] addr
);
    // ֧�������ĳ���������������ش�������λ�ߵ�ƽ��Ч
    always @(posedge clk)
    begin
        if(rst)
            addr <= 32'b0;
        else
            addr <= next;
    end

    initial
        $monitor($time, , "PC->next => 0x%8h", next);
endmodule
