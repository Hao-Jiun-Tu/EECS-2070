`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/17 14:52:19
// Design Name: 
// Module Name: test_comparator
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


module test_comparator;
reg [3-1:0] a, b;
wire a_lt_b, a_gt_b, a_eq_b;

Comparator_3bits U0(
    .a(a),
    .b(b),
    .a_lt_b(a_lt_b),
    .a_gt_b(a_gt_b),
    .a_eq_b(a_eq_b)
);

initial begin
    {a,b} = 6'b0;
    repeat (2 ** 6) begin
        #1 {a, b} = {a, b} + 1;
    end
        #1 $finish;
end


endmodule
