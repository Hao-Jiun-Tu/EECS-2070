`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/01 20:27:49
// Design Name: 
// Module Name: CLA_Adder
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
module CLA_Adder(A, B, C0, S, C4);
input [3:0] A, B;
input C0;
output [3:0] S;
output C4;
wire C1, C2, C3;
wire [3:0] p, g;

Xor P0(p[0], A[0], B[0]);
Xor P1(p[1], A[1], B[1]);
Xor P2(p[2], A[2], B[2]);
Xor P3(p[3], A[3], B[3]);

and G0(g[0], A[0], B[0]);
and G1(g[1], A[1], B[1]);
and G2(g[2], A[2], B[2]);
and G3(g[3], A[3], B[3]);
/************Calculate the  Carry****************/
wire x1;
and A1(x1, p[0], C0);
or Carry_1(C1, x1, g[0]);

wire y1, y2;
and A2(y1, p[1], g[0]);
and A3(y2, p[1], p[0], C0);
or Carry_2(C2, y1, y2, g[1]);

wire z1, z2, z3;
and A4(z1, p[2], g[1]);
and A5(z2, p[2], p[1], g[0]);
and A6(z3, p[2], p[1], p[0], C0);
or Carry_3(C3, z1, z2, z3, g[2]);

wire w1, w2, w3, w4;
and A7(w1, p[3], g[2]);
and A8(w2, p[3], p[2], g[1]);
and A9(w3, p[3], p[2], p[1], g[0]);
and A10(w4, p[3], p[2], p[1], p[0], C0);
or Carry_4(C4, w1, w2, w3, w4, g[3]);
/********1-bit FullAdder to Calculate the Sum for Every Digit******/
FA FA0(A[0], B[0], C0, S[0]);
FA FA1(A[1], B[1], C1, S[1]);
FA FA2(A[2], B[2], C2, S[2]);
FA FA3(A[3], B[3], C3, S[3]);
endmodule

module FA(A, B, C, S);
input A, B, C;
output S;
wire w1;
Xor W1(w1, A, B);
Xor Sum(S, w1, C);
endmodule

module Xor(Out, A, B);
input A, B;
output Out;
wire A_N, B_N, w1, w2;
not N1(A_N, A);
not N2(B_N, B);
and A1(w1, A_N, B);
and A2(w2, A, B_N);
or Or1(Out, w1, w2);
endmodule



