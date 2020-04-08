`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/01 13:46:54
// Design Name: 
// Module Name: Binary_To_GrayCode
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
module Binary_To_GrayCode(Din, Dout);
input [3:0] Din;
output [3:0] Dout;

and Digit3(Dout[3], Din[3]);
Xor Digit2(Din[3], Din[2], Dout[2]);
Xor Digit1(Din[2], Din[1], Dout[1]);
Xor Digit0(Din[1], Din[0], Dout[0]);
endmodule

module Xor(a, b, out);
input a, b;
output out;
wire a_not, b_not;
wire x1, x2;
not N0(a_not, a);
not N1(b_not, b);
and A1(x1, a_not, b);
and A2(x2, a, b_not);
or Or1(out, x1, x2);
endmodule