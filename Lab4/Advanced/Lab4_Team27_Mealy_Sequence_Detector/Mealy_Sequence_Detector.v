`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output dec;
reg dec;
parameter S0 = 4'b0000,
        S1 = 4'b0001,
        S2 = 4'b0010,
        S3 = 4'b0011,
        S4 = 4'b0100,
        S5 = 4'b0101,
        S6 = 4'b0110,
        S7 = 4'b0111,
        S8 = 4'b1000,
        S9 = 4'b1001;
reg [3:0] State, next_State;

always @(posedge clk) begin
    if(!rst_n)
        State <= S0;
    else
        State <= next_State;
end

always @(*) begin
    case(State)
    S0:
        if(in) begin
            dec = 1'b0;
            next_State = S1;
        end else begin
            dec = 1'b0;
            next_State = S4;
        end
    S1:
        if(in) begin
            dec = 1'b0;
            next_State = S2;
        end else begin
            dec = 1'b0;
            next_State = S7;
        end
    S2:
        if(!in) begin
            dec = 1'b0;
            next_State = S3;
        end else begin
            dec = 1'b0;
            next_State = S9;
        end
    S3:
        if(in) begin
            dec = 1'b1;
            next_State = S0;
        end else begin
            dec = 1'b0;
            next_State = S0;
        end
    S4: 
        if(in) begin
            dec = 1'b0;
            next_State = S5;
        end else begin
            dec = 1'b0;
            next_State = S5;
        end
    S5:
        if(in) begin
            dec = 1'b0;
            next_State = S6;
        end else begin
            dec = 1'b0;
            next_State = S6;
        end
    S6:
        if(in) begin
            dec = 1'b0;
            next_State = S0;
        end else begin
            dec = 1'b0;
            next_State = S0;
        end
    S7:
        if(in) begin
            dec = 1'b0;
            next_State = S8;
        end else begin
            dec = 1'b0;
            next_State = S8;
        end
    S8:
        if(in) begin
            dec = 1'b0;
            next_State = S0;
        end else begin
            dec = 1'b0;
            next_State = S0;
        end
    S9:
        if(in) begin
            dec = 1'b0;
            next_State = S0;
        end else begin
            dec = 1'b0;
            next_State = S0;
        end
    default:
        begin
            dec = 1'b0;
            next_State = S0;
        end
    endcase
end

endmodule
