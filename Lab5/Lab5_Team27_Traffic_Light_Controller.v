`timescale 1ns/1ps

module Traffic_Light_Controller (clk, rst_n, lr_has_car, hw_light, lr_light);
input clk, rst_n;
input lr_has_car;
output [3-1:0] hw_light;
output [3-1:0] lr_light;

reg [2:0] state;
reg [2:0] next_state;
reg [4:0] times;
reg [4:0] next_times;
reg [3-1:0] hw_light;
reg [3-1:0] lr_light;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;


always@(posedge clk) begin
    if(rst_n == 1'b0) begin
        state <= A;
        times <= 5'b0;
    end
    else begin
        state <= next_state;
        times <= next_times;
    end
end

always@* begin
    case(state) 
        A : begin
            hw_light = 3'b001;
            lr_light = 3'b100;
            if( ( (times == 5'd29) && lr_has_car) == 1'b1 ) begin
                next_times = 5'd0;
                next_state = B;
            end
            else begin
                if(times == 5'd29)
                    next_times = 5'd29;
                else
                    next_times = times + 1'b1;
                    
                next_state = A;
            end
        end
        B : begin
            hw_light = 3'b010;
            lr_light = 3'b100;
            if( times == 5'd9 ) begin
                next_times = 5'd0;
                next_state = C;
            end
            else begin
                next_times = times + 1'b1;
                next_state = B;
            end
        end
        C : begin
            hw_light = 3'b100;
            lr_light = 3'b100;
                next_times = 5'b0;
                next_state = D;
        end
        D : begin
            hw_light = 3'b100;
            lr_light = 3'b001;
            if(times == 5'd29) begin
                next_times = 5'b0;
                next_state = E;
            end
            else begin
                next_times = times + 1'b1;
                next_state = D;
            end
         end
         E : begin
            hw_light = 3'b100;
            lr_light = 3'b010;
            if(times == 5'd9) begin
                next_times = 5'b0;
                next_state = F;
            end
            else begin
                next_times = times + 1'b1;
                next_state = E;
            end
         end
         F : begin
            hw_light = 3'b100;
            lr_light = 3'b100;
                next_times = 5'b0;
                next_state = A;
         end  
    endcase
end

endmodule







