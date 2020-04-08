`timescale 1ns/1ps

`define CYC 4

module Ping_Pong_Counter_t;
reg clk = 1'b1;
reg rst_n = 1'b1;
reg enable = 1'b0;
reg [3:0]min, max;
reg flip;
wire direction;
wire [4-1:0] out;

Ping ppc (
  .clk (clk),
  .rst_n (rst_n),
  .enable (enable),
  .direction (direction),
  .out (out),
  .min(min),
  .flip(flip),
  .max(max)
);

always #(`CYC / 2) clk = ~clk;

initial begin
  flip = 1'b0;
  min = 4'd3;
  max = 4'd12;
  #(`CYC * 5)
  @ (negedge clk)
  rst_n = 1'b0;
  @ (negedge clk)
  rst_n = 1'b1;
  enable = 1'b1;

  #(`CYC * 20)
  enable = 1'b0;

  #(`CYC * 5)
  enable = 1'b1;
  #(`CYC * 5)
  min = 4'd7;
  max = 4'd15;
  
  @ (negedge clk)
  rst_n = 1'b0;
  @ (negedge clk)
  rst_n = 1'b1;
  
  #(`CYC * 20)
  @ (posedge clk)
  flip = 1'b1;
  @ (posedge clk)
  flip = 1'b0;
    #(`CYC * 20)
  
  min = 4'd7;
  max = 4'd8;
    #(`CYC * 5)
  min = 4'd0;
  max = 4'd15;
    #(`CYC * 5)
  min = 4'd8;
  max = 4'd2;
    #(`CYC * 5)
  
  $finish;
end
endmodule
