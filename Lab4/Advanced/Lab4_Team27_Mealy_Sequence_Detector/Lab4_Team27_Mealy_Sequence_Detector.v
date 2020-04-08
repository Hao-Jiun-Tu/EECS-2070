`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output dec;
reg dec;
reg [1:0] times;
reg [1:0] temp_times;
reg [1:0] state;
reg [1:0] next_state;
parameter S0 = 2'b00; 
parameter S1 = 2'b01; 
parameter S2 = 2'b10; 
parameter S3 = 2'b11; 
 
always @(posedge clk) begin
    if(~rst_n) begin
        state <= S0;
        times <= 2'b0;
    end
    else begin
        state <= next_state;
        times <= temp_times;
    end
end

always@* begin
    if(times == 2'b11) begin
        if((state == S3) && (in == 1'b1)) begin
            temp_times = 2'b00;
            next_state = S0;
            dec = 1'b1;
        end
        else begin
            temp_times = 2'b00;
            next_state = S0;
            dec = 1'b0;
        end
    end
    else begin
        temp_times = times + 1'b1;
        case(state)
            S0 :
                if(in == 1'b1) begin
                    next_state = S1;
                    dec = 1'b0;
                end
                else begin
                    next_state = S0;
                    dec= 1'b0;
                end
            S1:
                if(in == 1'b1) begin
                    next_state = S2;
                    dec = 1'b0;
                end
                else begin
                    next_state = S0;
                    dec= 1'b0;
                end
                
            S2:
                if(in == 1'b0) begin
                    next_state = S3;
                    dec = 1'b0;
                end
                else begin
                    next_state = S0;
                    dec= 1'b0;
                end
        endcase
    end
end

endmodule
