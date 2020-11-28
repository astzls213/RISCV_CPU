`timescale 1ns / 1ps

module ID(
    input [31:0] ins,       // ָ�����
    output [4:0] rs1,       // ԭ�������Ĵ���1
    output [4:0] rs2,       // ԭ�������Ĵ���2
    output [4:0] rd,        // Ŀ�Ĳ������Ĵ���
    output [6:0] opcode,    // ��������
    output [11:0] imm12,    // 12λ������
    output [19:0] imm20,    // 20λ������
    output [2:0] funct3,    // 3λ opcode ������
    output funct7           // 7λ opcode ������ (����1λ��ԭ���Ժ�˵��)
);
    /*
     * ָ�������� ID���� ins ����RISC-Vָ�����
     * �ֽ�ɸ������õ��ֶΣ��ṩ�� CU ģ�顣
     */

    // ���� RISC-V ָ�������и�ֵ
    assign opcode = ins[6:0];
    assign rs1 = ins[19:15];
    assign rs2 = ins[24:20];
    assign rd = ins[11:7];
    assign funct3 = ins[14:12];
    /* 
     * ��Ȼ funct7 Ϊ 7 λ����ʵ��������Ҫʵ�ֵ�
     * 37��ָ����� funct7 ֻ�� funct7[6] ��ͬ
     */
    assign funct7 = ins[30];

    /* 
     * ��������������΢����Щ����Ϊ����λ���� ins ��䶯
     * ���ɵó����ֲ�ͬ�� imm �ֲ���ʽ
     */ 
    wire fm1, fm2, fm3, fm4, fm5;
    
    // ��ʽ1 ����I��ָ���jalr opcode: 00x0011 �� 1100111
    assign fm1 = (~ins[6] & ~ins[5] & ~ins[3] & ~ins[2] & ins[1] & ins[0]) | 
                   ((&ins[6:5]) & ~(|ins[4:3]) & (&ins[2:0]));
    // ��ʽ2 ����B��ָ�� opcode: 1100011
    assign fm2 = (&ins[6:5]) & ~(|ins[4:2]) & (&ins[1:0]);
    // ��ʽ3 ����S��ָ�� opcode:0100011
    assign fm3 = ~ins[6] & ins[5] & ~(|ins[4:2]) & (&ins[1:0]);
    // ��ʽ4 jal opcode: 1101111
    assign fm4 = (&ins[6:5]) & ~ins[4] & (&ins[3:0]);
    // ��ʽ5 ����U��ָ�� opcode: 0x10111
    assign fm5 = ~ins[6] & ins[4] & ~ins[3] & (&ins[2:0]);

    assign imm12 = ({12{fm1}} & ins[31:20]) |
                   ({12{fm3}} & {ins[31], ins[7], ins[30:25], ins[11:8]}) |
                   ({12{fm2}} & {ins[31:25], ins[11:7]});

    assign imm20 = ({20{fm5}} & ins[31:12]) |
                   ({20{fm4}} & {ins[31], ins[19:12], ins[20], ins[30:21]});
endmodule
