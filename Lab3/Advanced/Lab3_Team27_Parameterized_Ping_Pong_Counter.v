`timescale 1ns/1ps 

module Ping (clk, rst_n, enable,flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;
reg [3:0] num, temp_num, new;
reg sign, temp_sign, en2, t_sign, en1;
reg next_sign;

always@(posedge clk) begin
    en1 <= enable;
end

always@(posedge clk) begin
    if(num <= max & num >= min & max > min)
        en2 = 1'b1;
    else 
        en2 = 1'b0;
end

always@(posedge clk) begin
    if(~rst_n) begin
        temp_num <= min;
    end
    else begin
        temp_num <= num; 
    end
end

always@(posedge clk) begin
    if(~rst_n) begin
        t_sign <= 1'b0;
    end
    else begin
        t_sign <= sign;
    end
end

always@* begin
    if(en1 & en2 & flip == 1'b1)
        temp_sign = ~t_sign;
    else
        temp_sign = t_sign;
end



always @* begin
    if(temp_sign == 1'b1) begin
        new = temp_num + 4'd15;
    end
    else begin
        new = temp_num + 1'b1;
    end
end

always @* begin
    if(en1 & en2 == 1'b1)
        num = new;
    else
        num = temp_num;
end


always @* begin
    if(num == max)
        sign = 1'b1;
    else if(num == min)
        sign = 1'b0;
    else
        sign = temp_sign;
end

always @(posedge clk) begin
    next_sign <= sign;
end

assign out = num;
assign direction = next_sign;

endmodule

