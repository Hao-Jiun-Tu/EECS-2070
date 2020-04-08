`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 15:52:57
// Design Name: 
// Module Name: Memory_t
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
`define CYC 4
module Memory_t;
reg clk = 1'b0, ren, wen;
reg [6-1:0] addr = 6'd0;
reg [8-1:0] din = 8'd0;
wire [8-1:0] dout;

Memory U0(.clk(clk),
         .ren(ren),
         .wen(wen),
         .addr(addr),
         .din(din),
         .dout(dout)
);

always #(`CYC / 4) clk = ~clk;
always #(`CYC * 8) ren = ~ren;
always #(`CYC * 9 ) wen = ~wen;

initial begin
  ren = 1'b0;
  wen = 1'b1;

  repeat (2 ** 14) begin
  @ (posedge clk)
  #(`CYC) {din, addr} = {din, addr} + 14'd8;
  end
  $finish;
end
endmodule
