`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/29 23:58:38
// Design Name: 
// Module Name: counter
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
module Top_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, segs, digits, out);
input clk, rst_n, enable, flip;
input [4-1:0] max;
input [4-1:0] min;
output [7:0] segs;
output [3:0] digits;
wire direction;

output [3:0] out;
wire [3:0] out1;
assign out = out1;


wire CLK;
wire [1:0] sctl_clk;
Clock_Divider U4(.clk(clk), .dclk(CLK), .sctl_clk(sctl_clk));

wire rst_n_deb, rst_n_pul;
wire flip_deb, flip_pul;
debounce U0(.pb_debounced(rst_n_deb), .pb(rst_n), .clk(clk));
onepulse U1(.PB_debounced(rst_n_deb), .CLK(CLK), .PB_one_pulse(rst_n_pul));
debounce U2(.pb_debounced(flip_deb), .pb(flip), .clk(clk));
onepulse U3(.PB_debounced(flip_deb), .CLK(CLK), .PB_one_pulse(flip_pul));


PPC U5(.clk(CLK), .rst_n(~rst_n_pul), .enable(enable), .flip(flip_pul), .max(max), .min(min), .direction(direction), .out(out1));
seven_segs U6(.din(out1), .direction(direction), .sctl_clk(sctl_clk), .segs(segs), .digits(digits));

endmodule