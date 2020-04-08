`timescale 1ns / 1ps

module seven_segs (din, direction, sctl_clk, segs, digits);
input [3:0] din;
input direction;
input [1:0] sctl_clk;
output [7:0] segs;
output [3:0] digits;
reg [3:0] digits;
reg [7:0] dout0, dout1, dout2, dout3;
reg [7:0] segs;

always @(*) begin
    case(din)
        4'd0 : dout0 = 8'b10010000;
        4'd1 : dout0 = 8'b11011011;
        4'd2 : dout0 = 8'b10001100;
        4'd3 : dout0 = 8'b10001001;
        4'd4 : dout0 = 8'b11000011;
        4'd5 : dout0 = 8'b10100001;
        4'd6 : dout0 = 8'b10100000;
        4'd7 : dout0 = 8'b10010011;
        4'd8 : dout0 = 8'b10000000;
        4'd9 : dout0 = 8'b10000001;
        4'd10 : dout0 = 8'b10010000;
        4'd11 : dout0 = 8'b11011011;
        4'd12 : dout0 = 8'b10001100;
        4'd13 : dout0 = 8'b10001001;
        4'd14 : dout0 = 8'b11000011;
        4'd15 : dout0 = 8'b10100001;
        default : dout0 = 8'b10010000;
    endcase
end
always @(*) begin
    if(din >= 4'd10)
        dout1 = 8'b11011011;
    else
        dout1 = 8'b10010000;
end

always @(*) begin
    if(direction == 1'b1) begin
        dout2 = 8'b11111000;
        dout3 = 8'b11111000;
    end else begin
        dout2 = 8'b10010111;
        dout3 = 8'b10010111;
    end
end

always@(*) begin
    case(sctl_clk)
        2'd0 : segs = dout0; 
        2'd1 : segs = dout1; 
        2'd2 : segs = dout2; 
        2'd3 : segs = dout3; 
        default : segs = 8'b0;
    endcase
end

always @(*) begin
    case(sctl_clk)
        2'd0 :  digits = 4'b1110;
        2'd1 :  digits = 4'b1101;
        2'd2 :  digits = 4'b1011;
        2'd3 :  digits = 4'b0111;
        default : digits = 4'b0000;
    endcase
end

endmodule