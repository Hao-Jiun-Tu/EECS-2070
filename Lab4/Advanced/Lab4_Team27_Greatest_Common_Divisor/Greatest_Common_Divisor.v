`timescale 1ns/1ps

module Greatest_Common_Divisor (clk, rst_n, Begin, a, b, Complete, gcd);
input clk, rst_n;
input Begin;
input [8-1:0] a;
input [8-1:0] b;
output Complete;
output [8-1:0] gcd;
/*output [8-1:0] a_reg;
output [8-1:0] b_reg;*/

wire Complete;
wire [8-1:0] gcd;

reg [8-1:0] gcd_reg;
reg [8-1:0] a_reg, next_a_reg;
reg [8-1:0] b_reg, next_b_reg;

parameter WAIT = 2'b00;
parameter CAL = 2'b01;
parameter FINISH = 2'b10;

reg [1:0] State, next_State;

always @(posedge clk) begin
    if(!rst_n)
        State <= WAIT;
    else
        State <= next_State;
end

always @(posedge clk) begin
        a_reg <= next_a_reg;
        b_reg <= next_b_reg;
end

always @(*) begin
    case(State)
    WAIT:
        if(!Begin) begin // Begin == 1'b0;
            next_a_reg = a; // Fetch the input;
            next_b_reg = b;
            next_State = CAL;    
        end else begin 
            next_State = WAIT;
        end
     CAL:
        if(a_reg == 8'd0) begin
            gcd_reg = b_reg;
            next_State = FINISH;
        end else if(b_reg == 8'd0) begin
            gcd_reg = a_reg;
            next_State = FINISH;
        end else if(a_reg > b_reg) begin
            next_a_reg = a_reg - b_reg; 
            next_State = CAL;
        end else begin
            next_b_reg = b_reg - a_reg;
            next_State = CAL;
        end 
     FINISH:
        begin
            next_State = WAIT;
        end   
    endcase
end

assign Complete = (State == FINISH) ? 1'b1 : 1'b0;
assign gcd = (State == FINISH) ? gcd_reg : 8'd0;

endmodule
