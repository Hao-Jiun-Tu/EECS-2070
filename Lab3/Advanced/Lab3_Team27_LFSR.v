`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 11:39:25
// Design Name: 
// Module Name: LFSR
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
module LFSR(clk, rst_n, out/*, DFF_out*/);
input clk, rst_n;
output out;
//output [3:0] DFF_out;
wire [3:0] DFF_out;
wire din;
DFF_rst_0 DFF_0(clk, din, rst_n, DFF_out[0]);
DFF_rst_0 DFF_1(clk, DFF_out[0], rst_n, DFF_out[1]);
DFF_rst_0 DFF_2(clk, DFF_out[1], rst_n, DFF_out[2]);
DFF_rst_1 DFF_3(clk, DFF_out[2], rst_n, DFF_out[3]);
DFF_rst_0 DFF_4(clk, DFF_out[3], rst_n, out);

assign din = out ^ DFF_out[2];
endmodule

module DFF_rst_0(clk, din, rst_n, dout);
input clk, din, rst_n;
output dout;
reg dout;
always@ (posedge clk)
begin
    if(!rst_n)
        dout <= 1'b0;
    else
        dout <= din;
end
endmodule

module DFF_rst_1(clk, din, rst_n, dout);
input clk, din, rst_n;
output dout;
reg dout;
always@ (posedge clk)
begin
    if(!rst_n)
        dout <= 1'b1;
    else
        dout <= din;
end
endmodule