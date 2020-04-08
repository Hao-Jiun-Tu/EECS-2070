`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/19 14:15:03
// Design Name: 
// Module Name: FullAdder
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
module FullAdder(A, B, Cin, Sum, Carry);
input A, B;
input Cin;
output Sum;
output Carry;
wire A_Not, B_Not, Cin_Not;
wire r1, r2, r3, r4;
wire Q, Q_Not;
wire w1, w2, w3;

not N1(A_Not, A);
not N2(B_Not, B);
not N3(Cin_Not, Cin);
/////////////////////////////////////////////
and A1(r1, A, B_Not);
and A2(r2, A_Not, B);
or U1(Q, r1, r2);
not N4(Q_Not, Q);          /*A (XOR) B (XOR) Cin*/
and A3(r3, Q, Cin_Not);
and A4(r4, Q_Not, Cin);
or U2(Sum, r3, r4);
/////////////////////////////////////////////

and A5(w1, A, B);
and A6(w2, B, Cin);
and A7(w3, Cin, A);
or C(Carry, w1, w2, w3);

endmodule