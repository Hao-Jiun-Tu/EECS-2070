`timescale 1ns / 1ps
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