`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 10:01:22
// Design Name: 
// Module Name: PingPong
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
module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
input clk, rst_n;
input enable;
output direction;
output [4-1:0] out;
reg [3:0] out = 4'b0000;
reg direction = 1'b0;
reg a = 1'b0;
always@ (posedge clk)
begin
    if(~rst_n)
    begin
        a <= 1'b0;
        out <= 4'b0000;
        direction <= 1'b0;
    end
    else if(~enable)
    begin
        a <= a;
        out <= out;
        direction <= direction;
    end
    else if(out == 4'd0 && enable == 1'b1)
    begin
        a <= 1'b1; 
        out <= out + 1'b1;
        direction <= 1'b0;
    end
    else if(out == 4'd15 && enable == 1'b1)
    begin
        a <= 1'b0;
        out <= out - 1'b1;
        direction <= 1'b1;
    end
    else if(a)
    begin
        a <= a;
        out <= out + 1'b1;
        direction <= 1'b0; 
    end
    else if(~a)
    begin
        a <= a;
        out <= out - 1'b1;
        direction <= 1'b1;
    end
end
endmodule
