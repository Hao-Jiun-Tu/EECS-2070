`timescale 1ns/1ps

module Decode_and_Execute (op_code, rs, rt, rd);
input [3-1:0] op_code;
input [4-1:0] rs, rt;
output [4-1:0] rd;
wire [7:0] sel;
wire [17:0] bf;
wire [3:0] rt_cpl;
wire [3:0] a, b, c, d, e, f, g, h, final;
wire [3:0] bf_a, bf_b, bf_c, bf_d, bf_e, bf_f, bf_g, bf_h;

//     case 000
nor b0(sel[0], op_code[0], op_code[1], op_code[2]);

ripple U0(
    .x(rs),
    .y(rt),
    .s(bf_a)
);

and a0(a[0], sel[0], bf_a[0]);
and a1(a[1], sel[0], bf_a[1]);
and a2(a[2], sel[0], bf_a[2]);
and a3(a[3], sel[0], bf_a[3]);


//      case 001
nor b2(bf[0], op_code[0], op_code[0]);
nor b3(sel[1], op_code[2], op_code[1], bf[0]);

not b28(bf[12], rt[0]);
not b27(bf[13], rt[1]);
not b29(bf[14], rt[2]);
not b30(bf[15], rt[3]);

ripple U1(
    .x(bf[15:12]),
    .y(4'b0001),
    .s(rt_cpl)
);

ripple U2(
    .x(rs),
    .y(rt_cpl),
    .s(bf_b)
);

and a4(b[0], sel[1], bf_b[0]);
and a5(b[1], sel[1], bf_b[1]); 
and a6(b[2], sel[1], bf_b[2]);
and a7(b[3], sel[1], bf_b[3]);


//      case 010
nor b5(bf[1], op_code[1], op_code[1]);
nor b6(sel[2], op_code[2], op_code[0], bf[1]);

ripple U3(
    .x(rs),
    .y(4'b0001),
    .s(bf_c)
);

and a8(c[0], sel[2], bf_c[0]);
and a9(c[1], sel[2], bf_c[1]);
and a10(c[2], sel[2], bf_c[2]);
and a11(c[3], sel[2], bf_c[3]);

//      case 011
nor b10(bf[2], op_code[0], op_code[0]);
nor b25(bf[3], op_code[1], op_code[1]);
nor b9(sel[3], bf[2], bf[3], op_code[2]);

nor d1(bf_d[3], rs[3], rt[3]);
nor d2(bf_d[2], rs[2], rt[2]);
nor d3(bf_d[1], rs[1], rt[1]);
nor d4(bf_d[0], rs[0], rt[0]);

and a12(d[0], sel[3], bf_d[0]);
and a13(d[1], sel[3], bf_d[1]);
and a14(d[2], sel[3], bf_d[2]);
and a15(d[3], sel[3], bf_d[3]);


//      case 100
nor b8(bf[4], op_code[2], op_code[2]);
nor b12(sel[4], bf[4], op_code[1], op_code[0]);

nand d5(bf_e[3], rs[3], rt[3]);
nand d6(bf_e[2], rs[2], rt[2]);
nand d7(bf_e[1], rs[1], rt[1]);
nand d8(bf_e[0], rs[0], rt[0]);

and a16(e[0], sel[4], bf_e[0]);
and a17(e[1], sel[4], bf_e[1]);
and a18(e[2], sel[4], bf_e[2]);
and a19(e[3], sel[4], bf_e[3]);

//      case 101
nor b13(bf[5], op_code[2], op_code[2]);
nor b14(bf[6], op_code[0], op_code[0]);
nor b15(sel[5], op_code[1], bf[5], bf[6]);

and f0(bf_f[0], rs[2], 1'b1);
and f1(bf_f[1], rs[3], 1'b1);
and f3(bf_f[2], rs[3], 1'b0);
and f4(bf_f[3], rs[2], 1'b0);

and a20(f[0], sel[5], bf_f[0]);
and a21(f[1], sel[5], bf_f[1]);
and a22(f[2], sel[5], bf_f[2]);
and a23(f[3], sel[5], bf_f[3]);


//      case 110
nor b17(bf[8], op_code[2], op_code[2]);
nor b18(bf[7], op_code[1], op_code[1]);
nor b19(sel[6], bf[8], bf[7], op_code[0]);

and g1(bf_g[0], rs[0], 1'b0);
and g2(bf_g[1], rs[0], 1'b1);
and g3(bf_g[2], rs[1], 1'b1);
and g4(bf_g[3], rs[2], 1'b1);

and a24(g[0], sel[6], bf_g[0]);
and a25(g[1], sel[6], bf_g[1]);
and a26(g[2], sel[6], bf_g[2]);
and a27(g[3], sel[6], bf_g[3]);

//      case 111
nor b21(bf[9], op_code[2], op_code[2]);
nor b22(bf[10], op_code[0], op_code[0]);
nor b23(bf[11], op_code[1], op_code[1]);
nor b24(sel[7], bf[9], bf[10], bf[11]);

Multiplier U7(
    .a(rs),
    .b(rt),
    .p(bf_h)
);

and a30(h[0], sel[7], bf_h[0]);
and a31(h[1], sel[7], bf_h[1]);
and a32(h[2], sel[7], bf_h[2]);
and a33(h[3], sel[7], bf_h[3]);

or fi0(rd[3], a[3], b[3], c[3], d[3], e[3], f[3], g[3], h[3]);
or fi1(rd[2], a[2], b[2], c[2], d[2], e[2], f[2], g[2], h[2]);
or fi2(rd[1], a[1], b[1], c[1], d[1], e[1], f[1], g[1], h[1]);
or fi3(rd[0], a[0], b[0], c[0], d[0], e[0], f[0], g[0], h[0]);

endmodule







module Multiplier (a, b, p);
input [4-1:0] a, b;
output [3:0] p;
wire [3:0] pp;
wire [3:0] a_and_b_1;
wire [3:0] a_and_b_2;
wire [3:0] a_and_b_3;
wire [3:0] a_and_b_4;

and(a_and_b_1[0], a[0], b[0]);
and(a_and_b_1[1], a[1], b[0]);
and(a_and_b_1[2], a[2], b[0]);
and(a_and_b_1[3], a[3], b[0]);
and(a_and_b_2[0], a[0], b[1]);
and(a_and_b_2[1], a[1], b[1]);
and(a_and_b_2[2], a[2], b[1]);
and(a_and_b_2[3], a[3], b[1]);
and(a_and_b_3[0], a[0], b[2]);
and(a_and_b_3[1], a[1], b[2]);
and(a_and_b_3[2], a[2], b[2]);
and(a_and_b_3[3], a[3], b[2]);
and(a_and_b_4[0], a[0], b[3]);
and(a_and_b_4[1], a[1], b[3]);
and(a_and_b_4[2], a[2], b[3]);
and(a_and_b_4[3], a[3], b[3]);

wire [3:0] bf1, bf2;
wire c0, c1;

ripple_5 V0(
    .x( {1'b0, a_and_b_1} ), 
    .y( {a_and_b_2, 1'b0} ),
    .s( { bf1, p[0] } ),
    .cout(c0)
);

ripple_5 V1(
    .x( {c0, bf1} ), 
    .y( {a_and_b_3, 1'b0} ),
    .s( { bf2, p[1] } ),
    .cout(c1)
);

ripple_5 V2(
    .x( {c1, bf2} ), 
    .y( {a_and_b_4, 1'b0} ),
    .s( {pp, p[3:2]} ),
    .cout(pp[3])
);

endmodule

module ripple_5(
    input [4:0] x, y,
    output [4:0] s,
    output cout
);

wire c1, c2, c3, c4;

fulladder U0(
    .A( x[0] ),
    .B( y[0] ),
    .C_in( 1'b0 ),
    .Sum( s[0] ),
    .C_out( c1 )
);

fulladder U1(
    .A( x[1] ),
    .B( y[1] ),
    .C_in( c1 ),
    .Sum( s[1] ),
    .C_out( c2 )
);

fulladder U2(
    .A( x[2] ),
    .B( y[2] ),
    .C_in( c2 ),
    .Sum( s[2] ),
    .C_out( c3 )
);

fulladder U3(
    .A( x[3] ),
    .B( y[3] ),
    .C_in( c3 ),
    .Sum( s[3] ),
    .C_out( c4 )
);

fulladder U4(
    .A( x[4] ),
    .B( y[4] ),
    .C_in( c4 ),
    .Sum( s[4] ),
    .C_out( cout )
);

endmodule


module ripple(
    input [3:0] x, y,
    output [3:0] s
);

wire c1, c2, c3;

fulladder U0(
    .A( x[0] ),
    .B( y[0] ),
    .C_in( 1'b0 ),
    .Sum( s[0] ),
    .C_out( c1 )
);

fulladder U1(
    .A( x[1] ),
    .B( y[1] ),
    .C_in( c1 ),
    .Sum( s[1] ),
    .C_out( c2 )
);

fulladder U2(
    .A( x[2] ),
    .B( y[2] ),
    .C_in( c2 ),
    .Sum( s[2] ),
    .C_out(c3)
);

fulladder U3(
    .A( x[3] ),
    .B( y[3] ),
    .C_in( c3 ),
    .Sum( s[3] )
);

endmodule

module fulladder(
 input A,
 input B,
 input C_in,
 output Sum,
 output C_out
);

wire w1,w2,w3;
wire r0, r1, r2, r3;
wire A_not, B_not, Cin_not, w1_not;

not(A_not, A);
not(B_not, B);
not(Cin_not, C_in);
not(w1_not, w1);

and f0(r0, A, B_not);
and f1(r1, A_not, B);
or  G1(w1, r0, r1);
///xor G1(w1, A, B);
and f2(r2, w1, Cin_not);
and f3(r3, w1_not, C_in);
or  G2(Sum, r2, r3); 
//xor G2(Sum, w1, C_in);
and G3(w2, w1, C_in);
and G4(w3, A, B);
or G5(C_out, w2, w3);

endmodule



