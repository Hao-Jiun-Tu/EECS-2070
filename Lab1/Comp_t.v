`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/17 20:49:41
// Design Name: 
// Module Name: Comp_t
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


module Comp_t;
reg [2:0]A = 1'b0;
reg [2:0]B = 1'b0;
wire eq, gt, lt;

Comp U0(
    .A(A),
    .B(B),
    .eq(eq),
    .gt(gt),
    .lt(lt)
);  

initial begin
    repeat(2 ** 6) begin
        #1 {A, B} = {A, B} + 1'b1;
    end
    #1 $finish;
end
    
endmodule
