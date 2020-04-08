`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/16 19:38:19
// Design Name: 
// Module Name: Mux_8bits
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


module Mux_8bits (a, b, sel, f);
input [8-1:0] a, b;
input sel;
output [8-1:0] f;

wire b1[7:0], b2[7:0];

and(b1[0], a[0], sel);
and(b2[0], b[0], ~sel);
or(f[0], b1[0], b2[0]);

and(b1[1], a[1], sel);
and(b2[1], b[1], ~sel);
or(f[1], b1[1], b2[1]);

and(b1[2], a[2], sel);
and(b2[2], b[2], ~sel);
or(f[2], b1[2], b2[2]);

and(b1[3], a[3], sel);
and(b2[3], b[3], ~sel);
or(f[3], b1[3], b2[3]);

and(b1[4], a[4], sel);
and(b2[4], b[4], ~sel);
or(f[4], b1[4], b2[4]);

and(b1[5], a[5], sel);
and(b2[5], b[5], ~sel);
or(f[5], b1[5], b2[5]);

and(b1[6], a[6], sel);
and(b2[6], b[6], ~sel);
or(f[6], b1[6], b2[6]);

and(b1[7], a[7], sel);
and(b2[7], b[7], ~sel);
or(f[7], b1[7], b2[7]);

endmodule

















