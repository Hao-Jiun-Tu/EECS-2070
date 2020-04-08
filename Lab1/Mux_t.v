`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/18 13:33:15
// Design Name: 
// Module Name: Mux_t
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
module Mux_t;
reg [7:0]A = 8'b00000000;
reg [7:0]B = 8'b00000000;
reg sel = 1'b0;
wire [7:0]F;
Mux U0(  .A(A),
        .B(B),
        .sel(sel),
        .F(F)
);

initial begin 
    repeat (2 ** 17) begin
        #0.001 {A, B, sel} = {A, B, sel} + 17'b00000000000000001;
    end
    #0.01 $finish;
end
endmodule
