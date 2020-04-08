`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 13:52:10
// Design Name: 
// Module Name: Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Memory(clk, ren, wen, addr, din, dout);
input clk;
input ren, wen;
input [6-1:0] addr;
input [8-1:0] din;
output [8-1:0] dout;
reg [8-1:0] dout;
wire [8-1:0] din0, din1, din2, din3, din4, din5, din6, din7,
din8, din9, din10, din11, din12, din13, din14, din15,
din16, din17, din18, din19, din20, din21, din22, din23,
din24, din25, din26, din27, din28, din29, din30, din31,
din32, din33, din34, din35, din36, din37, din38, din39,
din40, din41, din42, din43, din44, din45, din46, din47,
din48, din49, din50, din51, din52, din53, din54, din55,
din56, din57, din58, din59, din60, din61, din62, din63;

wire [8-1:0] w0, w1, w2, w3, w4, w5, w6, w7,
w8, w9, w10, w11, w12, w13, w14, w15,
w16, w17, w18, w19, w20, w21, w22, w23,
w24, w25, w26, w27, w28, w29, w30, w31,
w32, w33, w34, w35, w36, w37, w38, w39,
w40, w41, w42, w43, w44, w45, w46, w47,
w48, w49, w50, w51, w52, w53, w54, w55,
w56, w57, w58, w59, w60, w61, w62, w63;

assign din0 = (addr == 6'd0 && wen == 1 && ren == 1'b0) ? din : w0;
assign din1 = (addr == 6'd1 && wen == 1 && ren == 1'b0) ? din : w1;
assign din2 = (addr == 6'd2 && wen == 1 && ren == 1'b0) ? din : w2;
assign din3 = (addr == 6'd3 && wen == 1 && ren == 1'b0) ? din : w3;
assign din4 = (addr == 6'd4 && wen == 1 && ren == 1'b0) ? din : w4;
assign din5 = (addr == 6'd5 && wen == 1 && ren == 1'b0) ? din : w5;
assign din6 = (addr == 6'd6 && wen == 1 && ren == 1'b0) ? din : w6;
assign din7 = (addr == 6'd7 && wen == 1 && ren == 1'b0) ? din : w7;
assign din8 = (addr == 6'd8 && wen == 1 && ren == 1'b0) ? din : w8;
assign din9 = (addr == 6'd9 && wen == 1 && ren == 1'b0) ? din : w9;
assign din10 = (addr == 6'd10 && wen == 1 && ren == 1'b0) ? din : w10;
assign din11 = (addr == 6'd11 && wen == 1 && ren == 1'b0) ? din : w11;
assign din12 = (addr == 6'd12 && wen == 1 && ren == 1'b0) ? din : w12;
assign din13 = (addr == 6'd13 && wen == 1 && ren == 1'b0) ? din : w13;
assign din14 = (addr == 6'd14 && wen == 1 && ren == 1'b0) ? din : w14;
assign din15 = (addr == 6'd15 && wen == 1 && ren == 1'b0) ? din : w15;
assign din16 = (addr == 6'd16 && wen == 1 && ren == 1'b0) ? din : w16;
assign din17 = (addr == 6'd17 && wen == 1 && ren == 1'b0) ? din : w17;
assign din18 = (addr == 6'd18 && wen == 1 && ren == 1'b0) ? din : w18;
assign din19 = (addr == 6'd19 && wen == 1 && ren == 1'b0) ? din : w19;
assign din20 = (addr == 6'd20 && wen == 1 && ren == 1'b0) ? din : w20;
assign din21 = (addr == 6'd21 && wen == 1 && ren == 1'b0) ? din : w21;
assign din22 = (addr == 6'd22 && wen == 1 && ren == 1'b0) ? din : w22;
assign din23 = (addr == 6'd23 && wen == 1 && ren == 1'b0) ? din : w23;
assign din24 = (addr == 6'd24 && wen == 1 && ren == 1'b0) ? din : w24;
assign din25 = (addr == 6'd25 && wen == 1 && ren == 1'b0) ? din : w25;
assign din26 = (addr == 6'd26 && wen == 1 && ren == 1'b0) ? din : w26;
assign din27 = (addr == 6'd27 && wen == 1 && ren == 1'b0) ? din : w27;
assign din28 = (addr == 6'd28 && wen == 1 && ren == 1'b0) ? din : w28;
assign din29 = (addr == 6'd29 && wen == 1 && ren == 1'b0) ? din : w29;
assign din30 = (addr == 6'd30 && wen == 1 && ren == 1'b0) ? din : w30;
assign din31 = (addr == 6'd31 && wen == 1 && ren == 1'b0) ? din : w31;
assign din32 = (addr == 6'd32 && wen == 1 && ren == 1'b0) ? din : w32;
assign din33 = (addr == 6'd33 && wen == 1 && ren == 1'b0) ? din : w33;
assign din34 = (addr == 6'd34 && wen == 1 && ren == 1'b0) ? din : w34;
assign din35 = (addr == 6'd35 && wen == 1 && ren == 1'b0) ? din : w35;
assign din36 = (addr == 6'd36 && wen == 1 && ren == 1'b0) ? din : w36;
assign din37 = (addr == 6'd37 && wen == 1 && ren == 1'b0) ? din : w37;
assign din38 = (addr == 6'd38 && wen == 1 && ren == 1'b0) ? din : w38;
assign din39 = (addr == 6'd39 && wen == 1 && ren == 1'b0) ? din : w39;
assign din40 = (addr == 6'd40 && wen == 1 && ren == 1'b0) ? din : w40;
assign din41 = (addr == 6'd41 && wen == 1 && ren == 1'b0) ? din : w41;
assign din42 = (addr == 6'd42 && wen == 1 && ren == 1'b0) ? din : w42;
assign din43 = (addr == 6'd43 && wen == 1 && ren == 1'b0) ? din : w43;
assign din44 = (addr == 6'd44 && wen == 1 && ren == 1'b0) ? din : w44;
assign din45 = (addr == 6'd45 && wen == 1 && ren == 1'b0) ? din : w45;
assign din46 = (addr == 6'd46 && wen == 1 && ren == 1'b0) ? din : w46;
assign din47 = (addr == 6'd47 && wen == 1 && ren == 1'b0) ? din : w47;
assign din48 = (addr == 6'd48 && wen == 1 && ren == 1'b0) ? din : w48;
assign din49 = (addr == 6'd49 && wen == 1 && ren == 1'b0) ? din : w49;
assign din50 = (addr == 6'd50 && wen == 1 && ren == 1'b0) ? din : w50;
assign din51 = (addr == 6'd51 && wen == 1 && ren == 1'b0) ? din : w51;
assign din52 = (addr == 6'd52 && wen == 1 && ren == 1'b0) ? din : w52;
assign din53 = (addr == 6'd53 && wen == 1 && ren == 1'b0) ? din : w53;
assign din54 = (addr == 6'd54 && wen == 1 && ren == 1'b0) ? din : w54;
assign din55 = (addr == 6'd55 && wen == 1 && ren == 1'b0) ? din : w55;
assign din56 = (addr == 6'd56 && wen == 1 && ren == 1'b0) ? din : w56;
assign din57 = (addr == 6'd57 && wen == 1 && ren == 1'b0) ? din : w57;
assign din58 = (addr == 6'd58 && wen == 1 && ren == 1'b0) ? din : w58;
assign din59 = (addr == 6'd59 && wen == 1 && ren == 1'b0) ? din : w59;
assign din60 = (addr == 6'd60 && wen == 1 && ren == 1'b0) ? din : w60;
assign din61 = (addr == 6'd61 && wen == 1 && ren == 1'b0) ? din : w61;
assign din62 = (addr == 6'd62 && wen == 1 && ren == 1'b0) ? din : w62;
assign din63 = (addr == 6'd63 && wen == 1 && ren == 1'b0) ? din : w63;

DFF D0(clk, ren, wen, din0, w0);
DFF D1(clk, ren, wen, din1, w1);
DFF D2(clk, ren, wen, din2, w2);
DFF D3(clk, ren, wen, din3, w3);
DFF D4(clk, ren, wen, din4, w4);
DFF D5(clk, ren, wen, din5, w5);
DFF D6(clk, ren, wen, din6, w6);
DFF D7(clk, ren, wen, din7, w7);
DFF D8(clk, ren, wen, din8, w8);
DFF D9(clk, ren, wen, din9, w9);
DFF D10(clk, ren, wen, din10, w10);
DFF D11(clk, ren, wen, din11, w11);
DFF D12(clk, ren, wen, din12, w12);
DFF D13(clk, ren, wen, din13, w13);
DFF D14(clk, ren, wen, din14, w14);
DFF D15(clk, ren, wen, din15, w15);
DFF D16(clk, ren, wen, din16, w16);
DFF D17(clk, ren, wen, din17, w17);
DFF D18(clk, ren, wen, din18, w18);
DFF D19(clk, ren, wen, din19, w19);
DFF D20(clk, ren, wen, din20, w20);
DFF D21(clk, ren, wen, din21, w21);
DFF D22(clk, ren, wen, din22, w22);
DFF D23(clk, ren, wen, din23, w23);
DFF D24(clk, ren, wen, din24, w24);
DFF D25(clk, ren, wen, din25, w25);
DFF D26(clk, ren, wen, din26, w26);
DFF D27(clk, ren, wen, din27, w27);
DFF D28(clk, ren, wen, din28, w28);
DFF D29(clk, ren, wen, din29, w29);
DFF D30(clk, ren, wen, din30, w30);
DFF D31(clk, ren, wen, din31, w31);
DFF D32(clk, ren, wen, din32, w32);
DFF D33(clk, ren, wen, din33, w33);
DFF D34(clk, ren, wen, din34, w34);
DFF D35(clk, ren, wen, din35, w35);
DFF D36(clk, ren, wen, din36, w36);
DFF D37(clk, ren, wen, din37, w37);
DFF D38(clk, ren, wen, din38, w38);
DFF D39(clk, ren, wen, din39, w39);
DFF D40(clk, ren, wen, din40, w40);
DFF D41(clk, ren, wen, din41, w41);
DFF D42(clk, ren, wen, din42, w42);
DFF D43(clk, ren, wen, din43, w43);
DFF D44(clk, ren, wen, din44, w44);
DFF D45(clk, ren, wen, din45, w45);
DFF D46(clk, ren, wen, din46, w46);
DFF D47(clk, ren, wen, din47, w47);
DFF D48(clk, ren, wen, din48, w48);
DFF D49(clk, ren, wen, din49, w49);
DFF D50(clk, ren, wen, din50, w50);
DFF D51(clk, ren, wen, din51, w51);
DFF D52(clk, ren, wen, din52, w52);
DFF D53(clk, ren, wen, din53, w53);
DFF D54(clk, ren, wen, din54, w54);
DFF D55(clk, ren, wen, din55, w55);
DFF D56(clk, ren, wen, din56, w56);
DFF D57(clk, ren, wen, din57, w57);
DFF D58(clk, ren, wen, din58, w58);
DFF D59(clk, ren, wen, din59, w59);
DFF D60(clk, ren, wen, din60, w60);
DFF D61(clk, ren, wen, din61, w61);
DFF D62(clk, ren, wen, din62, w62);
DFF D63(clk, ren, wen, din63, w63);

always@ (*)
    case({addr,ren})
        7'd0:dout = 8'd0;
        7'd1:dout = w0;
        7'd2:dout = 8'd0;
        7'd3:dout = w1;
        7'd4:dout = 8'd0;
        7'd5:dout = w2;
        7'd6:dout = 8'd0;
        7'd7:dout = w3;
        7'd8:dout = 8'd0;
        7'd9:dout = w4;
        7'd10:dout = 8'd0;
        7'd11:dout = w5;
        7'd12:dout = 8'd0;
        7'd13:dout = w6;
        7'd14:dout = 8'd0;
        7'd15:dout = w7;
        7'd16:dout = 8'd0;
        7'd17:dout = w8;
        7'd18:dout = 8'd0;
        7'd19:dout = w9;
        7'd20:dout = 8'd0;
        7'd21:dout = w10;
        7'd22:dout = 8'd0;
        7'd23:dout = w11;
        7'd24:dout = 8'd0;
        7'd25:dout = w12;
        7'd26:dout = 8'd0;
        7'd27:dout = w13;
        7'd28:dout = 8'd0;
        7'd29:dout = w14;
        7'd30:dout = 8'd0;
        7'd31:dout = w15;
        7'd32:dout = 8'd0;
        7'd33:dout = w16;
        7'd34:dout = 8'd0;
        7'd35:dout = w17;
        7'd36:dout = 8'd0;
        7'd37:dout = w18;
        7'd38:dout = 8'd0;
        7'd39:dout = w19;
        7'd40:dout = 8'd0;
        7'd41:dout = w20;
        7'd42:dout = 8'd0;
        7'd43:dout = w21;
        7'd44:dout = 8'd0;
        7'd45:dout = w22;
        7'd46:dout = 8'd0;
        7'd47:dout = w23;
        7'd48:dout = 8'd0;
        7'd49:dout = w24;
        7'd50:dout = 8'd0;
        7'd51:dout = w25;
        7'd52:dout = 8'd0;
        7'd53:dout = w26;
        7'd54:dout = 8'd0;
        7'd55:dout = w27;
        7'd56:dout = 8'd0;
        7'd57:dout = w28;
        7'd58:dout = 8'd0;
        7'd59:dout = w29;
        7'd60:dout = 8'd0;
        7'd61:dout = w30;
        7'd62:dout = 8'd0;
        7'd63:dout = w31;
        7'd64:dout = 8'd0;
        7'd65:dout = w32;
        7'd66:dout = 8'd0;
        7'd67:dout = w33;
        7'd68:dout = 8'd0;
        7'd69:dout = w34;
        7'd70:dout = 8'd0;
        7'd71:dout = w35;
        7'd72:dout = 8'd0;
        7'd73:dout = w36;
        7'd74:dout = 8'd0;
        7'd75:dout = w37;
        7'd76:dout = 8'd0;
        7'd77:dout = w38;
        7'd78:dout = 8'd0;
        7'd79:dout = w39;
        7'd80:dout = 8'd0;
        7'd81:dout = w40;
        7'd82:dout = 8'd0;
        7'd83:dout = w41;
        7'd84:dout = 8'd0;
        7'd85:dout = w42;
        7'd86:dout = 8'd0;
        7'd87:dout = w43;
        7'd88:dout = 8'd0;
        7'd89:dout = w44;
        7'd90:dout = 8'd0;
        7'd91:dout = w45;
        7'd92:dout = 8'd0;
        7'd93:dout = w46;
        7'd94:dout = 8'd0;
        7'd95:dout = w47;
        7'd96:dout = 8'd0;
        7'd97:dout = w48;
        7'd98:dout = 8'd0;
        7'd99:dout = w49;
        7'd100:dout = 8'd0;
        7'd101:dout = w50;
        7'd102:dout = 8'd0;
        7'd103:dout = w51;
        7'd104:dout = 8'd0;
        7'd105:dout = w52;
        7'd106:dout = 8'd0;
        7'd107:dout = w53;
        7'd108:dout = 8'd0;
        7'd109:dout = w54;
        7'd110:dout = 8'd0;
        7'd111:dout = w55;
        7'd112:dout = 8'd0;
        7'd113:dout = w56;
        7'd114:dout = 8'd0;
        7'd115:dout = w57;
        7'd116:dout = 8'd0;
        7'd117:dout = w58;
        7'd118:dout = 8'd0;
        7'd119:dout = w59;
        7'd120:dout = 8'd0;
        7'd121:dout = w60;
        7'd122:dout = 8'd0;
        7'd123:dout = w61;
        7'd124:dout = 8'd0;
        7'd125:dout = w62;
        7'd126:dout = 8'd0;
        7'd127:dout = w63;
    endcase
endmodule

module DFF(clk, ren, wen, din, dout);
input clk, ren, wen;
input [8-1:0] din;
output [8-1:0] dout;
reg [8-1:0] dout;
always@ (posedge clk)
begin
   dout <= din;
end
endmodule
