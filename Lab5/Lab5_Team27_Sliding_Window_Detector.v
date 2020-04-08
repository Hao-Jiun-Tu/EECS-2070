`timescale 1ns/1ps

module Sliding_Window_Detector (clk, rst_n, in, dec1, dec2);
input clk, rst_n;
input in;
output dec1, dec2;
reg dec1, dec2;

//parameter for dec1
parameter S0 = 3'b000,
         S1 = 3'b001,
         S2 = 3'b010,
         S3 = 3'b011,
         S4 = 3'b100,
         S5 = 3'b101,
         S6 = 3'b110;

//parameter for dec2
parameter s0 = 3'b000,
         s1 = 3'b001,
         s2 = 3'b010,
         s3 = 3'b011,
         s4 = 3'b100; 
//for dec1      
reg [2:0] State, next_State;
//for dec2
reg [2:0] state, next_state;

always @(posedge clk) begin
    if(!rst_n) begin
        State <= S0;
        state <= s0;
    end else begin
        State <= next_State;
        state <= next_state;
    end
end

//for dec1 
always @(*) begin
    case(State)
    S0:
        if(in) begin
            next_State = S1;
            dec1 = 1'b0;
        end else begin
            next_State = S0;
            dec1 = 1'b0;
        end
    S1:
        if(!in) begin
            next_State = S2;
            dec1 = 1'b0;
        end else begin
            next_State = S4;
            dec1 = 1'b0;
        end
    S2:
        if(in) begin
            next_State = S3;
            dec1 = 1'b1;
        end else begin
            next_State = S0;
            dec1 = 1'b0;
        end
    S3:
        if(in) begin
            next_State = S6;
            dec1 = 1'b0;
        end else begin  
            next_State = S2;
            dec1 = 1'b0;
        end
    S4:
        if(in) begin
            next_State = S5;
            dec1 = 1'b0;
        end else begin
            next_State = S2;
            dec1 = 1'b0;
        end
    S5:
       begin
            next_State = State;
            dec1 = 1'b0;
        end
    S6:
        if(in) begin
            next_State = S5;
            dec1 = 1'b0;
        end else begin
            next_State = S2;
            dec1 = 1'b0;
        end
    default:
        begin
            next_State = S0;
            dec1 = 1'b0;
        end
    endcase   
end

//for dec2
always @(*) begin
    case(state)
    s0:
        if(in) begin
            next_state = s1;
            dec2 = 1'b0;
        end else begin
            next_state = s0;
            dec2 = 1'b0;
        end
    s1:
        if(!in) begin
            next_state = s2;
            dec2 = 1'b0;
        end else begin
            next_state = s1;
            dec2 = 1'b0;
        end
    s2:
        if(!in) begin
            next_state = s3;
            dec2 = 1'b0;
        end else begin
            next_state = s1;
            dec2 = 1'b0;
        end
    s3:
        if(in) begin
            next_state = s4;
            dec2 = 1'b1;
        end else begin
            next_state = s0;
            dec2 = 1'b0;
        end
    s4:
        if(in) begin
            next_state = s1;
            dec2 = 1'b0;
        end else begin
            next_state = s2;
            dec2 = 1'b0;
        end
    default:
        begin
            next_state = s0;
            dec2 = 1'b0;
        end
    endcase    
end

endmodule
