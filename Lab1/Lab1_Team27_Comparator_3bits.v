`timescale 1ns/1ps

module Comparator_3bits (a, b, a_lt_b, a_gt_b, a_eq_b);
input [3-1:0] a, b;
output [2:0]a_lt_b;
output [2:0]a_gt_b;
output [9:0]a_eq_b;

wire [2:0] anb, abn , aeqb;
wire [2:0] a_not, b_not;

not(a_not[0], a[0]);
not(a_not[1], a[1]);
not(a_not[2], a[2]);
not(b_not[0], b[0]);
not(b_not[1], b[1]);
not(b_not[2], b[2]);

and(anb[0], a_not[0], b[0]);
and(anb[1], a_not[1], b[1]);
and(anb[2], a_not[2], b[2]);
and(abn[0], a[0], b_not[0]);
and(abn[1], a[1], b_not[1]);
and(abn[2], a[2], b_not[2]);

nor(aeqb[0], anb[0], abn[0]);
nor(aeqb[1], anb[1], abn[1]);
nor(aeqb[2], anb[2], abn[2]);


wire [5:0]bf;

// tackle a > b
and(bf[0], aeqb[2], abn[1]);
and(bf[1], aeqb[2], aeqb[1], abn[0]);

or(a_gt_b[2], abn[2], bf[0], bf[1]);
or(a_gt_b[1], abn[2], bf[0], bf[1]);
or(a_gt_b[0], abn[2], bf[0], bf[1]);

// tackle a < b
and(bf[2], aeqb[2], anb[1]);
and(bf[3], aeqb[2], aeqb[1], anb[0]);

or(a_lt_b[2], anb[2], bf[2], bf[3]);
or(a_lt_b[1], anb[2], bf[2], bf[3]);
or(a_lt_b[0], anb[2], bf[2], bf[3]);

// tackle a == b
and(a_eq_b[0], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[1], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[2], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[3], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[4], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[5], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[6], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[7], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[8], aeqb[2], aeqb[1], aeqb[0]);
and(a_eq_b[9], aeqb[2], aeqb[1], aeqb[0]);

endmodule
