`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/18 13:14:15
// Design Name: 
// Module Name: Mux
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

module Mux(A, B, sel, F);
input [7:0]A, B;
input sel;
output [7:0]F;
wire sel_N;
wire w0, w1, w2, w3, w4, w5, w6, w7;
wire r0, r1, r2, r3, r4, r5, r6, r7;

not N(sel_N, sel);
and A0(w0, A[0], sel);
and A1(w1, A[1], sel);
and A2(w2, A[2], sel);
and A3(w3, A[3], sel);
and A4(w4, A[4], sel);
and A5(w5, A[5], sel);
and A6(w6, A[6], sel);
and A7(w7, A[7], sel);

and B0(r0, B[0], sel_N);
and B1(r1, B[1], sel_N);
and B2(r2, B[2], sel_N);
and B3(r3, B[3], sel_N);
and B4(r4, B[4], sel_N);
and B5(r5, B[5], sel_N);
and B6(r6, B[6], sel_N);
and B7(r7, B[7], sel_N);

or U0(F[0], w0, r0);
or U1(F[1], w1, r1);
or U2(F[2], w2, r2);
or U3(F[3], w3, r3);
or U4(F[4], w4, r4);
or U5(F[5], w5, r5);
or U6(F[6], w6, r6);
or U7(F[7], w7, r7);

endmodule
