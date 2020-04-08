`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/02 13:21:14
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
module CLA_Adder(A, B, Cin, Dark_bits, Dec_out);
input [3:0] A, B;
input Cin;
output [3:0] Dark_bits;
assign Dark_bits = 4'b1110; //1 stands for darkmess; 0 stands for brightness
output [7:0] Dec_out;
wire [3:0] S;
wire C1, C2, C3, C4;
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
and A1(x1, p[0], Cin);
or Carry_1(C1, x1, g[0]);

wire y1, y2;
and A2(y1, p[1], g[0]);
and A3(y2, p[1], p[0], Cin);
or Carry_2(C2, y1, y2, g[1]);

wire z1, z2, z3;
and A4(z1, p[2], g[1]);
and A5(z2, p[2], p[1], g[0]);
and A6(z3, p[2], p[1], p[0], Cin);
or Carry_3(C3, z1, z2, z3, g[2]);

wire w1, w2, w3, w4;
and A7(w1, p[3], g[2]);
and A8(w2, p[3], p[2], g[1]);
and A9(w3, p[3], p[2], p[1], g[0]);
and A10(w4, p[3], p[2], p[1], p[0], Cin);
or Carry_4(C4, w1, w2, w3, w4, g[3]);
/********1-bit FullAdder to Calculate the Sum for Every Digit******/
FA FA0(A[0], B[0], Cin, S[0]);
FA FA1(A[1], B[1], C1, S[1]);
FA FA2(A[2], B[2], C2, S[2]);
FA FA3(A[3], B[3], C3, S[3]);

Decoder Dec(C4, S, Dec_out);
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

module Decoder(cout, sum, out);
input [3:0] sum;
input cout;
output [7:0] out;
reg [7:0] out;
always @*
    case({cout, sum})
        5'd0 : out = 8'b1_0010000;
        5'd1 : out = 8'b1_1011011;
        5'd2 : out = 8'b1_0001100;
        5'd3 : out = 8'b1_0001001;
        5'd4 : out = 8'b1_1000011;
        5'd5 : out = 8'b1_0100001;
        5'd6 : out = 8'b1_0100000;
        5'd7 : out = 8'b1_0010011;
        5'd8 : out = 8'b1_0000000;
        5'd9 : out = 8'b1_0000001;
        5'd10 : out = 8'b1_0000010;
        5'd11 : out = 8'b1_1100000;
        5'd12 : out = 8'b1_0110100;
        5'd13 : out = 8'b1_1001000;
        5'd14 : out = 8'b1_0100100;
        5'd15 : out = 8'b1_0100110;
        
        5'd16 : out = 8'b0_0010000;
        5'd17 : out = 8'b0_1011011;
        5'd18 : out = 8'b0_0001100;
        5'd19 : out = 8'b0_0001001;
        5'd20 : out = 8'b0_1000011;
        5'd21 : out = 8'b0_0100001;
        5'd22 : out = 8'b0_0100000;
        5'd23 : out = 8'b0_0010011;
        5'd24 : out = 8'b0_0000000;
        5'd25 : out = 8'b0_0000001;
        5'd26 : out = 8'b0_0000010;
        5'd27 : out = 8'b0_1100000;
        5'd28 : out = 8'b0_0110100;
        5'd29 : out = 8'b0_1001000;
        5'd30 : out = 8'b0_0100100;
        5'd31 : out = 8'b0_0100110;
    endcase
endmodule
