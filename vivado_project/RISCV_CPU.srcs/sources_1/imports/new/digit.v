`timescale 1ns / 1ps

module digit(
    input [15:0] data,
    input clk,
    output reg[6:0] a2g,
    output reg[3:0] an
    );
    reg[1:0] status = 2'b00;
    reg[3:0] digit;

    // ���������
    always @(posedge clk)
        status<=status+1'b1;

    // ���ݲ�ͬ״̬��ȷ����ʾ��4λ���ǵ�4λ     
    always @(*)
    case(status)
        2'b00:begin digit = data[15:12]; an=4'b1000;end
        2'b01:begin digit = data[11:8];  an=4'b0100;end
        2'b10:begin digit = data[7:4];   an=4'b0010;end
        2'b11:begin digit = data[3:0];   an=4'b0001;end
        
        default:begin digit=data[3:0]; an=4'b0001;end
    endcase
            
    //��������digit�����ò�ͬ��a~g��
    always @(*)
    case(digit)
            4'h0:a2g=7'b1111110;
            4'h1:a2g=7'b0110000;
            4'h2:a2g=7'b1101101;
            4'h3:a2g=7'b1111001;
            4'h4:a2g=7'b0110011;
            4'h5:a2g=7'b1011011;
            4'h6:a2g=7'b1011111;
            4'h7:a2g=7'b1110000;
            4'h8:a2g=7'b1111111;
            4'h9:a2g=7'b1111011;
            4'hA:a2g=7'b1110111;
            4'hB:a2g=7'b0011111;
            4'hC:a2g=7'b1001110;
            4'hD:a2g=7'b0111101;
            4'hE:a2g=7'b1001111;
            4'hF:a2g=7'b1000111;
            default:a2g=7'b1111110;
    endcase
endmodule
