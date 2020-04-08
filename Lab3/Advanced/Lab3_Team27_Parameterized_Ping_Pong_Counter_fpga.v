`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 02:35:31
// Design Name: 
// Module Name: TOP
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
module TOP(clk, rst_n, enable,flip, max, min, direction, out, segs, ssd_ctl);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;
output [7:0] segs;
output [3:0] ssd_ctl;
wire flip_debounced;
wire flip_onepulse;
wire [3:0] temp_ssd_ctl;
wire clk_27;
wire y_flip;
wire [1:0] sctl_clk;
wire [3:0]temp_out;
wire sign, rst_deb;
reg [3:0] ssd_ctl;

assign out = temp_out;

debounce U9(
    .clk(clk),
    .pb(rst_n),
    .pb_debounced(rst_deb)
);

debounce U10(
    .clk(clk),
    .pb(flip),
    .pb_debounced(flip_debounced)
);

onepulse U11(
    .CLK(clk),
    .PB_debounced(flip_debounced),
    .PB_one_pulse(flip_onepulse)
);

frequency_divider U0(
    .clk(clk),
    .clk_27(clk_27),
    .sctl_clk(sctl_clk)
);

Ping U1(
    .clk(clk_27),
    .rst_n(rst_deb),
    .enable(enable),
    .flip(flip_onepulse),
    .max(max),
    .min(min),
    .direction(sign),
    .out(temp_out)
);

sevin_seg U2 (
    .din(temp_out),
    .final(segs),
    .sign(sign),
    .sctl_clk(sctl_clk)   
);

always@* begin
    case(sctl_clk)
        4'd0 :  ssd_ctl = 4'b1110;
        4'd1 :  ssd_ctl = 4'b1101;
        4'd2 :  ssd_ctl = 4'b1011;
        4'd3 :  ssd_ctl = 4'b0111;
    endcase
end

endmodule

module debounce (pb_debounced, pb, clk);
 output pb_debounced; // signal of a pushbutton after being debounced
 input pb; // signal from a pushbutton
 input clk;

 reg [3:0] DFF; // use shift_reg to filter pushbutton bounce
 always @(posedge clk)
 begin
 DFF[3:1] <= DFF[2:0];
 DFF[0] <= pb;
 end
 assign pb_debounced = ((DFF == 4'b1111) ? 1'b0 : 1'b1);
endmodule



module onepulse (PB_debounced, CLK, PB_one_pulse);
 input PB_debounced;
 input CLK;
 output PB_one_pulse;
 reg PB_one_pulse;
 reg PB_debounced_delay;
 always @(posedge CLK) begin
 PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
 PB_debounced_delay <= PB_debounced;
 end
endmodule

module frequency_divider(
    input clk,
    output clk_27,
    output [1:0] sctl_clk
);
reg [25:0]temp = 27'b0;

always@(posedge clk) begin
    temp = temp + 1'b1;
end

assign clk_27 = temp[25];
assign sctl_clk = {temp[15:14]};

endmodule

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

module sevin_seg(
    input [1:0] sctl_clk,
    input sign,
    input [3:0] din,
    output [7:0] final
);
reg [7:0] dout_0, dout_1, dout_2, dout_3;
reg [7:0] fin;
    
always@* begin
    case(din)
        4'd0 : dout_0 = 8'b00000011;
        4'd1 : dout_0 = 8'b10011111;
        4'd2 : dout_0 = 8'b00100101;
        4'd3 : dout_0 = 8'b00001101;
        4'd4 : dout_0 = 8'b10011001;
        4'd5 : dout_0 = 8'b01001001;
        4'd6 : dout_0 = 8'b01000001;
        4'd7 : dout_0 = 8'b00011111;
        4'd8 : dout_0 = 8'b00000001;
        4'd9 : dout_0 = 8'b00001001;
        4'd10 : dout_0 = 8'b00000011;
        4'd11 : dout_0 = 8'b10011111;
        4'd12 : dout_0 = 8'b00100101;
        4'd13 : dout_0 = 8'b00001101;
        4'd14 : dout_0 = 8'b10011001;
        4'd15 : dout_0 = 8'b01001001;
    endcase
end

always@*begin
    if(din >= 4'b1010) begin
        dout_1 = 8'b10011111;
    end
    else begin
        dout_1 = 8'b11111111;
    end
end

always@* begin
    if(sign == 1'b1) begin
        dout_3 = 8'b00111011;
        dout_2 = 8'b00111011;
    end
    else begin
        dout_3 = 8'b11000111;
        dout_2 = 8'b11000111;
    end
end

always@* begin
    case(sctl_clk)
        4'd0 : fin = dout_0; 
        4'd1 : fin = dout_1; 
        4'd2 : fin = dout_2; 
        4'd3 : fin = dout_3; 
    endcase
end

assign final = fin;

    
endmodule

