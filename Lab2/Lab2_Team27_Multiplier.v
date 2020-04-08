`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/01 14:24:13
// Design Name: 
// Module Name: Multiplier
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
module Multiplier(A, B, P);
input [3:0] A, B;
output [7:0] P;
wire [3:0] A0B, A1B, A2B, A3B;
and A0(A0B[0], A[0], B[0]);
and A1(A0B[1], A[0], B[1]);
and A2(A0B[2], A[0], B[2]);
and A3(A0B[3], A[0], B[3]);

and A4(A1B[0], A[1], B[0]);
and A5(A1B[1], A[1], B[1]);
and A6(A1B[2], A[1], B[2]);
and A7(A1B[3], A[1], B[3]);

and A8(A2B[0], A[2], B[0]);
and A9(A2B[1], A[2], B[1]);
and A10(A2B[2], A[2], B[2]);
and A11(A2B[3], A[2], B[3]);

and A12(A3B[0], A[3], B[0]);
and A13(A3B[1], A[3], B[1]);
and A14(A3B[2], A[3], B[2]);
and A15(A3B[3], A[3], B[3]);
wire [11:0] Carry;
wire [5:0] Sum_reg;
or Digit0(P[0], A0B[0]);

FA Digit1(A1B[0], A0B[1], 0, Carry[0], P[1]);
 
FA Cal_1(A2B[0], A1B[1], A0B[2], Carry[1], Sum_reg[0]);
FA Digit2(Sum_reg[0], Carry[0], 0, Carry[2], P[2]);

FA Cal_2(A3B[0], A2B[1], A1B[2], Carry[3], Sum_reg[1]);
FA Cal_3(A0B[3], Carry[1], Carry[2], Carry[4], Sum_reg[2]);
FA Digit3(Sum_reg[1], Sum_reg[2], 0, Carry[5], P[3]);

FA Cal_4(A3B[1], A2B[2], A1B[3], Carry[6], Sum_reg[3]);
FA Cal_5(Carry[3], Carry[4], Carry[5], Carry[7], Sum_reg[4]);
FA Digit4(Sum_reg[3], Sum_reg[4], 0, Carry[8], P[4]);

FA Cal_6(A3B[2], A2B[3], Carry[6], Carry[9], Sum_reg[5]);
FA Digit5(Sum_reg[5], Carry[7], Carry[8], Carry[10], P[5]);

FA Digit6(A3B[3], Carry[9], Carry[10], Carry[11], P[6]);

or Digit7(P[7], Carry[11]);
endmodule

module FA(A, B, C_in, Carry, Sum);
input A, B, C_in;
output Carry, Sum;
wire w1, w2, w3, w4;
Xor XOR1(A, B, w1);
Xor XOR2(w1, C_in, Sum);

and A1(w2, A, B);
and A2(w3, B, C_in);
and A3(w4, C_in, A);
or Or1(Carry, w2, w3, w4);
endmodule

module Xor(A, B, Out);
input A, B;
output Out;
wire A_N, B_N, x1, x2;
not N1(A_N, A);
not N2(B_N, B);
and A1(x1, A_N, B);
and A2(x2, A, B_N);
or Or1(Out, x1, x2);
endmodule