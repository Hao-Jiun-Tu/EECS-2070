`timescale 1ns / 1ps
module seven_seg(digit0, digit3, digit12, sctl_clk, digit_display, segs);
input [3:0] digit0, digit3;
input [5:0] digit12;
input [1:0] sctl_clk;
output [3:0] digit_display;
output [7:0] segs;
reg [3:0] digit_display;
reg [7:0] segs;
reg [7:0] dout0, dout1, dout2, dout3;

always @(*) begin
    case(digit0)
        4'd0 : dout0 = 8'b00000011;
        4'd1 : dout0 = 8'b10011111;
        4'd2 : dout0 = 8'b00100101;
        4'd3 : dout0 = 8'b00001101;
        4'd4 : dout0 = 8'b10011001;
        4'd5 : dout0 = 8'b01001001;
        4'd6 : dout0 = 8'b01000001;
        4'd7 : dout0 = 8'b00011011;
        4'd8 : dout0 = 8'b00000001;
        4'd9 : dout0 = 8'b00001001;
        default : dout0 = 8'b00000011; 
    endcase
end

always @(*) begin
    case(digit3)
        4'd0 : dout3 = 8'b00000011;
        4'd1 : dout3 = 8'b10011111;
        4'd2 : dout3 = 8'b00100101;
        4'd3 : dout3 = 8'b00001101;
        4'd4 : dout3 = 8'b10011001;
        4'd5 : dout3 = 8'b01001001;
        4'd6 : dout3 = 8'b01000001;
        4'd7 : dout3 = 8'b00011011;
        4'd8 : dout3 = 8'b00000001;
        4'd9 : dout3 = 8'b00001001;
        default : dout3 = 8'b00000011; 
    endcase
end

always @(*) begin
    if(digit12 == 6'd0 || digit12 == 6'd10 || digit12 == 6'd20 || digit12 == 6'd30 || digit12 == 6'd40 || digit12 == 6'd50)
        dout1 = 8'b00000010;
    else if(digit12 == 6'd1 || digit12 == 6'd11 || digit12 == 6'd21 || digit12 == 6'd31 || digit12 == 6'd41 || digit12 == 6'd51)
        dout1 = 8'b10011110;
    else if(digit12 == 6'd2 || digit12 == 6'd12 || digit12 == 6'd22 || digit12 == 6'd32 || digit12 == 6'd42 || digit12 == 6'd52)
        dout1 = 8'b00100100;
    else if(digit12 == 6'd3 || digit12 == 6'd13 || digit12 == 6'd23 || digit12 == 6'd33 || digit12 == 6'd43 || digit12 == 6'd53)
        dout1 = 8'b00001100;
    else if(digit12 == 6'd4 || digit12 == 6'd14 || digit12 == 6'd24 || digit12 == 6'd34 || digit12 == 6'd44 || digit12 == 6'd54)
        dout1 = 8'b10011000;
    else if(digit12 == 6'd5 || digit12 == 6'd15 || digit12 == 6'd25 || digit12 == 6'd35 || digit12 == 6'd45 || digit12 == 6'd55)
        dout1 = 8'b01001000;
    else if(digit12 == 6'd6 || digit12 == 6'd16 || digit12 == 6'd26 || digit12 == 6'd36 || digit12 == 6'd46 || digit12 == 6'd56)
        dout1 = 8'b01000000;
    else if(digit12 == 6'd7 || digit12 == 6'd17 || digit12 == 6'd27 || digit12 == 6'd37 || digit12 == 6'd47 || digit12 == 6'd57)
        dout1 = 8'b00011010;
    else if(digit12 == 6'd8 || digit12 == 6'd18 || digit12 == 6'd28 || digit12 == 6'd38 || digit12 == 6'd48 || digit12 == 6'd58)
        dout1 = 8'b00000000;
    else if(digit12 == 6'd9 || digit12 == 6'd19 || digit12 == 6'd29 || digit12 == 6'd39 || digit12 == 6'd49 || digit12 == 6'd59)
        dout1 = 8'b00001000;
    else
        dout1 = 8'b00000010;
end

always @(*) begin
    if(digit12 >= 6'd50) 
        dout2 = 8'b01001001;
    else if(digit12 >= 6'd40)
        dout2 = 8'b10011001;
    else if(digit12 >= 6'd30)
        dout2 = 8'b00001101;
    else if(digit12 >= 6'd20)
        dout2 = 8'b00100101;
    else if(digit12 >= 6'd10)
        dout2 = 8'b10011111;
    else
        dout2 = 8'b00000011;            
end

always@(*) begin
    case(sctl_clk)
        2'd0 : segs = dout0; 
        2'd1 : segs = dout1; 
        2'd2 : segs = dout2; 
        2'd3 : segs = dout3; 
    endcase
end

always@(*) begin
    case(sctl_clk)
        2'd0 : digit_display = 4'b1110; 
        2'd1 : digit_display = 4'b1101; 
        2'd2 : digit_display = 4'b1011; 
        2'd3 : digit_display = 4'b0111; 
    endcase
end
endmodule