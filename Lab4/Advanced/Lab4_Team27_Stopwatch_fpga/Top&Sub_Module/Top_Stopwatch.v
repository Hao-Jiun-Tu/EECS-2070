`timescale 1ns / 1ps
module Top_Stopwatch(clk, reset, up_button, digit_display, segs);
input clk, reset, up_button;
output [3:0] digit_display;
output [7:0] segs;
wire [3:0] digit0, digit3;
wire [5:0] digit12;

wire dclk;
wire [1:0] sctl_clk;
wire reset_deb, reset_pul;
wire up_button_deb, up_button_pul;
Clock_Divider U0(.clk(clk), .dclk(dclk), .sctl_clk(sctl_clk));

debounce U1(.pb_debounced(reset_deb), .pb(reset), .clk(clk));
onepulse U2(.PB_debounced(reset_deb), .CLK(dclk), .PB_one_pulse(reset_pul));

debounce U3(.pb_debounced(up_button_deb), .pb(up_button), .clk(clk));
onepulse U4(.PB_debounced(up_button_deb), .CLK(dclk), .PB_one_pulse(up_button_pul));

Stopwatch U5(.clk(dclk), .reset(~reset_pul), .up_button(up_button_pul), .digit0(digit0), .digit12(digit12), .digit3(digit3));

seven_seg U6(.digit0(digit0), .digit3(digit3), .digit12(digit12), .sctl_clk(sctl_clk), .digit_display(digit_display), .segs(segs));
endmodule
