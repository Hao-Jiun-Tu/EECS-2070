`timescale 1ns/1ps

module Greatest_Common_Divisor (clk, rst_n, Begin, a, b, Complete, gcd);
input clk, rst_n;
input Begin;
input [8-1:0] a;
input [8-1:0] b;
output Complete;
output [8-1:0] gcd;
reg [8-1:0] gcd;
reg [1:0] state;
reg [1:0] next_state;
reg [7:0] next_x, next_y;
reg [7:0] x, y;
reg Complete;

parameter WAIT = 2'b00;
parameter CAL = 2'b01;
parameter FINISH = 2'b10;

always @(posedge clk) begin
    if(~rst_n) begin
        state <= WAIT;
        x <= 8'b0;
        y <= 8'b0;
    end
    else begin
        state <= next_state;
        x <= next_x;
        y <= next_y;
    end
end

always @* begin
    case(state)
        WAIT :
            if(Begin == 1'b0) begin
                next_x = a;
                next_y = b;
                next_state = CAL;
            end
            else begin
                next_x = 8'b0;
                next_y = 8'b0;
                next_state = WAIT;
            end
        CAL : 
            if({x} == {y}) begin
                next_state = FINISH;
                next_x = x;
                next_y = 8'b0;
            end
            else begin
                if({x} > {y}) begin
                    next_x = {x} - {y};
                    next_y = y;
                    next_state = CAL;
                end
                else begin
                    next_x = x;
                    next_y = {y} - {x};
                    next_state = CAL;
                end
            end
        FINISH : 
            begin
                next_x = 8'b0;
                next_y = 8'b0;
                next_state = WAIT;
            end
    endcase
end

always@* begin
    if(state == FINISH) begin
        Complete = 1'b1; 
        gcd = x;
    end
    else begin
        Complete = 1'b0;
        gcd = 8'b0;
    end
end

endmodule




