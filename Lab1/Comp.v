`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/17 20:19:25
// Design Name: 
// Module Name: Comp
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


module Comp(A, B, eq, gt, lt);
input [2:0]A, B;
output eq, gt, lt;
wire [2:0]A_not, B_not;
wire x0, x1, x2;  //XNOR
wire gt0, gt1, gt2;
wire lt0, lt1, lt2;
not N1(A_not[2], A[2]);
not N2(A_not[1], A[1]);
not N3(A_not[0], A[0]);
not N4(B_not[2], B[2]);
not N5(B_not[1], B[1]);
not N6(B_not[0], B[0]);

xnor X0(x0, A[0], B[0]);
xnor X1(x1, A[1], B[1]);
xnor X2(x2, A[2], B[2]);

and G0(gt2, A[2], B_not[2]);
and G1(gt1, x2, A[1], B_not[1]);
and G2(gt0, x2, x1, A[0], B_not[0]);

and L0(lt2, A_not[2], B[2]);
and L1(lt1, x2, A_not[1], B[1]);
and L2(lt0, x2, x1, A_not[0], B[0]);

and U0(eq, x2, x1, x0);
or U1(gt, gt2, gt1, gt0);
or U2(lt, lt2, lt1, lt0);

endmodule
