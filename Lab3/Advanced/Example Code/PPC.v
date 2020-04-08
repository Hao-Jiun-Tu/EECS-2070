`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 21:41:25
// Design Name: 
// Module Name: PPC
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
module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;
reg direction, next_direction;
reg [4-1:0] out, next_out;
reg check_rst;

parameter up = 1'b0;
parameter down = 1'b1;

wire isborder = ((out == max || out == min) && check_rst);
wire out_of_range = (out > max || out < min);
wire available = (enable && max > min && !out_of_range);
wire Flip = (flip && out < max && out > min);


always @(posedge clk) begin
    if(!rst_n) begin
        out <= min;
        direction <= up;
        check_rst <= 1'b0;
     end else begin
        out <= next_out;
        direction <= next_direction;
        check_rst <= 1'b1;
     end
end

always @(*) begin
    if(!available) begin
        next_direction = direction;
        next_out = out;
    end else begin
        if(isborder) begin
           next_direction = !direction;
           next_out = (direction == up) ? out - 1'b1 : out + 1'b1;
        end else begin
            if(Flip) begin
                next_direction = !direction;
                next_out = (direction == up) ? out - 1'b1 : out + 1'b1;
            end else begin
                if(direction == up) begin
                    next_direction = up;
                    next_out = out + 1'b1;
                end else begin
                    next_direction = down;
                    next_out = out - 1'b1;
                end
            end
        end
    end    
 end       
       
endmodule