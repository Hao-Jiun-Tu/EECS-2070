`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/16 22:45:36
// Design Name: 
// Module Name: dec
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


module dec(Din, Dout);
input [3:0]Din;
output [15:0]Dout;

wire [3:0]Din_N;
not N1(Din_N[0], Din[0]);
not N2(Din_N[1], Din[1]);
not N3(Din_N[2], Din[2]);
not N4(Din_N[3], Din[3]);

and A1(Dout[0], Din[0], Din[1], Din[2], Din[3]);
and A2(Dout[1], Din_N[0], Din[1], Din[2], Din[3]);
and A3(Dout[2], Din[0], Din_N[1], Din[2], Din[3]);
and A4(Dout[3], Din_N[0], Din_N[1], Din[2], Din[3]);
and A5(Dout[4], Din[0], Din[1], Din_N[2], Din[3]);
and A6(Dout[5], Din_N[0], Din[1], Din_N[2], Din[3]);
and A7(Dout[6], Din[0], Din_N[1], Din_N[2], Din[3]);
and A8(Dout[7], Din_N[0], Din_N[1], Din_N[2], Din[3]);
///////////////////////////////////////////////////////////////////////////////////////////
and A9(Dout[8], Din_N[0], Din_N[1], Din_N[2], Din_N[3]);
and A10(Dout[9], Din[0], Din_N[1], Din_N[2], Din_N[3]);
and A11(Dout[10], Din_N[0], Din[1], Din_N[2], Din_N[3]);
and A12(Dout[11], Din[0], Din[1], Din_N[2], Din_N[3]);
and A13(Dout[12], Din_N[0], Din_N[1], Din[2], Din_N[3]);
and A14(Dout[13], Din[0], Din_N[1], Din[2], Din_N[3]);
and A15(Dout[14], Din_N[0], Din[1], Din[2], Din_N[3]);
and A16(Dout[15], Din[0], Din[1], Din[2], Din_N[3]);

endmodule
