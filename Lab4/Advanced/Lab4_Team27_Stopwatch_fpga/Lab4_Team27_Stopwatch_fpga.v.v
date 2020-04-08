`timescale 1ns / 1ps
module Top_Stopwatch(clk, reset, up_button, digit_display, segs);
input clk, reset, up_button;
output [3:0] digit_display;
output [7:0] segs;
wire [3:0] digit0, digit3;
wire [5:0] digit12;

wire dclk;
wire [1:0] sctl_clk;
wire reset_deb, reset_pul;
wire up_button_deb, up_button_pul;
Clock_Divider U0(.clk(clk), .dclk(dclk), .sctl_clk(sctl_clk));

debounce U1(.pb_debounced(reset_deb), .pb(reset), .clk(clk));
onepulse U2(.PB_debounced(reset_deb), .CLK(dclk), .PB_one_pulse(reset_pul));

debounce U3(.pb_debounced(up_button_deb), .pb(up_button), .clk(clk));
onepulse U4(.PB_debounced(up_button_deb), .CLK(dclk), .PB_one_pulse(up_button_pul));

Stopwatch U5(.clk(dclk), .reset(~reset_pul), .up_button(up_button_pul), .digit0(digit0), .digit12(digit12), .digit3(digit3));

seven_seg U6(.digit0(digit0), .digit3(digit3), .digit12(digit12), .sctl_clk(sctl_clk), .digit_display(digit_display), .segs(segs));
endmodule


module Stopwatch(clk, reset, up_button, digit0, digit12, digit3);
input clk, reset, up_button;
output [3:0] digit0, digit3;
output [5:0] digit12;
reg [3:0] digit0, digit3;
reg [5:0] digit12;
reg [3:0] next_digit0, next_digit3;
reg [5:0] next_digit12;
parameter S0 = 2'b00; //Reset State
parameter S1 = 2'b01; //Wait State
parameter S2 = 2'b10; //Count State 
reg [1:0] State, next_State;
always @(posedge clk) begin
    if(!reset)
    State <= S0;
    else
    State <= next_State;
end

always @(posedge clk) begin
    digit0 <= next_digit0;
    digit12 <= next_digit12;
    digit3 <= next_digit3;
end

always @(*) begin
    case(State)
    S0:  /*Reset State*/
        begin
            next_digit0 = 4'd0;
            next_digit12 = 6'd0;
            next_digit3 = 4'd0;
            next_State = S1;
         end
     S1: /*Wait State*/
        if(!reset) begin
            next_digit0 = 4'd0;
            next_digit12 = 6'd0;
            next_digit3 = 4'd0;
            next_State = S0;
         end else if(!up_button) begin
            next_digit0 = digit0;
            next_digit12 = digit12;
            next_digit3 = digit3;
            next_State = State;
         end else begin
            next_digit0 = digit0;
            next_digit12 = digit12;
            next_digit3 = digit3;
            next_State = S2;
         end
     S2:  /*Count State*/
         if(!reset) begin
            next_digit0 = 4'd0;
            next_digit12 = 6'd0;
            next_digit3 = 4'd0;
            next_State = S0;
         end else if(!up_button) begin
            if(digit3 == 4'd9 && digit12 == 6'd59 && digit0 == 4'd9) begin
                next_digit0 = 4'd0;
                next_digit12 = 6'd0;
                next_digit3 = 4'd0;
                next_State = S1;
            end else if(digit12 == 6'd59 && digit0 == 4'd9) begin
                next_digit0 = 4'd0;
                next_digit12 = 6'd0;
                next_digit3 = digit3 + 1'b1;
                next_State = State;
            end else if(digit0 == 4'd9)begin
                next_digit0 = 4'd0;
                next_digit12 = digit12 + 1'b1;
                next_digit3 = digit3;
                next_State = State;
            end else begin
                next_digit0 = digit0 + 1'b1;
                next_digit12 = digit12;
                next_digit3 = digit3;
                next_State = State;
            end        
         end else begin
            next_digit0 = digit0;
            next_digit12 = digit12;
            next_digit3 = digit3;
            next_State = S1;
         end
     default : begin
            next_digit0 = 4'd0;
            next_digit12 = 6'd0;
            next_digit3 = 4'd0;
            next_State = S0;
     end
     endcase
end


endmodule

module Clock_Divider #(parameter n = 24) (clk, dclk, sctl_clk);
input clk;
output dclk;
output [1:0] sctl_clk;
reg [n-1:0] num;
wire [n-1:0] next_num;
always @(posedge clk) begin
    if(num[n-1] == 1'b1 && num[n-4] == 1'b1 && num[n-5] == 1'b1)
        num <= 24'd0;
    else
        num <= next_num;
end
assign next_num = num + 1'b1;
assign dclk = num[n-1];
assign sctl_clk = {num[15:14]};

endmodule


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


module debounce (pb_debounced, pb, clk);
output pb_debounced; // signal of a pushbutton after being debounced
input pb; // signal from a pushbutton
input clk;

reg [3:0] DFF; // use shift_reg to filter pushbutton bounce
always @(posedge clk) begin
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
