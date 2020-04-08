`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/02 17:41:49
// Design Name: 
// Module Name: Lab4_Team27_Greatest_Common_Divisor_t
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


module test;
reg clk = 1'b0, rst_n = 1'b0, Begin = 1'b1;
reg [7:0]a, b;
wire Complete;
wire [7:0]gcd;

Greatest_Common_Divisor U0(
    .clk(clk),
    .rst_n(rst_n),
    .Begin(Begin),
    .a(a),
    .b(b),
    .Complete(Complete),
    .gcd(gcd)
);

always #1 clk = ~clk;

initial begin
    #2 rst_n = 1'b1;
    #10 Begin = 1'b0;
    a = 24;
    b = 16;
    #2 Begin = 1'b1;
    a = 8'b0;
    b = 8'b0;
    
    #15 Begin = 1'b0;
    a = 72;
    b = 72;
    #2 Begin = 1'b1;
    a = 8'b0;
    b = 8'b0;
    
    #6 Begin = 1'b0;
    a = 10;
    b = 20;
    #2 Begin = 1'b1;
    a = 8'b0;
    b = 8'b0;
    
    #8 Begin = 1'b0;
    a = 96;
    b = 25;
    #2
    Begin = 1'b1;
    {a,b} = 16'b0;
    #10
    a = 87;
    b = 29;
    #5 Begin = 1'b0;
    a = 5;
    b = 20;
    #2 Begin = 1'b1
    ;a = 0; b = 0;
    
    #15 $finish;
end

endmodule



