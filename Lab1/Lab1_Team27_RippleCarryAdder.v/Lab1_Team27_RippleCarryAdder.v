`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/19 14:13:27
// Design Name: 
// Module Name: RippleCarryAdder
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
module RippleCarryAdder(A, B, Cin, Sum, Cout);
input [3:0]A, B;
input Cin;
output [3:0]Sum;
output Cout;
wire c1, c2, c3;

FullAdder Digit0(A[0], B[0], Cin, Sum[0], c1);
FullAdder Digit1(A[1], B[1], c1, Sum[1], c2);
FullAdder Digit2(A[2], B[2], c2, Sum[2], c3);
FullAdder Digit3(A[3], B[3], c3, Sum[3], Cout);

endmodule