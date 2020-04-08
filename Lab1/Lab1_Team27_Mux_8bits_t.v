
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/16 20:38:32
// Design Name: 
// Module Name: test_mux
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


`timescale 1ns/1ps

module Mux_8bit_t;
reg [7:0]a = 8'b0;
reg [7:0]b = 8'b0;
reg sel = 1'b0;
wire [7:0]f;

Mux_8bits U0 (
  .a (a),
  .b (b),
  .sel (sel),
  .f (f)
);

initial begin
  repeat (2 ** 17) begin
    #1 {a, b, sel} = {a, b, sel} + 1'b1;
  end
  #1 $finish;
end
endmodule

