`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output dec;

parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;
parameter S3 = 3'd3;
parameter S4 = 3'd4;
parameter S5 = 3'd5;
parameter S6 = 3'd6;
parameter S7 = 3'd7;

reg dec;
reg [2:0] state;
reg [2:0] next_state;

always@(posedge clk) begin
    if(~rst_n) 
        state <= 3'b0;
    else
        state <= next_state;
end


always@* begin
    case(state) 
        S0: begin
            if(in == 1'b0) begin
                dec = 1'b0;
                next_state = S5; 
            end
            else begin
                dec = 1'b0;
                next_state = S1;
            end
        end
        S1: begin
            if(in == 1'b1) begin
                dec = 1'b0;
                next_state = S2; 
            end
            else begin
                dec = 1'b0;
                next_state = S4;
            end
        end
        S2: begin
            if(in == 1'b0) begin
                dec = 1'b0;
                next_state = S3; 
            end
            else begin
                dec = 1'b0;
                next_state = S7;
            end
        end
        S3: begin
            if(in == 1'b1) begin
                dec = 1'b1;
                next_state = S0; 
            end
            else begin
                dec = 1'b0;
                next_state = S0;
            end
        end
        S4: begin
            if(in == 1'b1) begin
                dec = 1'b0;
                next_state = S3; 
            end
            else begin
                dec = 1'b0;
                next_state = S7;
            end
        end
        S5: begin
                dec = 1'b0;
                next_state = S6; 
        end
        S6: begin
                dec = 1'b0;
                next_state = S7; 
        end
        S7: begin
                dec = 1'b0;
                next_state = S0; 
        end
    endcase
end


endmodule
