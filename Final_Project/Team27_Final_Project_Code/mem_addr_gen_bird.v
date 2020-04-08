`timescale 1ns / 1ps

module mem_addr_gen_Bird(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input c_up,
   input restart,
   input gogacu_signal,
   input [11:0] pipe_pixel,
   output reg [9:0] position_y,
   output reg [16:0] pixel_addr,
   output wire collision
   );
   
   wire [9:0] bird_right;
   wire signal_up, signal_down, signal_left, signal_right;
   
   reg [11:0] color_up, color_down, color_left, color_right;
   reg [9:0] next_position_y;
   reg [9:0] distance, next_distance;
   reg [3:0] state, next_state;
   parameter WAIT = 3'b000;
   parameter MOTION = 3'b001;
   parameter DROP = 3'b010;
   parameter DEATH = 3'b100;
   
   assign bird_right = 9'd80;
   
   assign signal_up = ((h_cnt == 9'd100 && v_cnt == position_y - 9'd20) ? 0 : 1);
   assign signal_down = ((h_cnt == 9'd100 && v_cnt == position_y + 9'd20) ? 0 : 1);
   assign signal_left = ((h_cnt == 9'd80 && v_cnt == position_y) ? 0 : 1);
   assign signal_right = ((h_cnt == 9'd120 && v_cnt == position_y) ? 0 : 1);
   
   always@(posedge signal_up) color_up <= pipe_pixel;
   always@(posedge signal_down) color_down <= pipe_pixel;
   always@(posedge signal_left) color_left <= pipe_pixel;
   always@(posedge signal_right) color_right <= pipe_pixel;
   assign collision = ((color_up != 12'h534) || (color_down != 12'h534) || (color_left != 12'h534) || (color_right != 12'h534)) && (gogacu_signal == 1'b0) || (state == DEATH || state == DROP) ;
   
   
   
   always@(*) begin
        if(h_cnt >= 80 && h_cnt < 120 && v_cnt >= ((position_y - 20) % 480) && v_cnt < ((position_y + 20) % 480))
            pixel_addr = (40 * (v_cnt - ((position_y - 20) % 480)) + h_cnt - 9'd80 );
        else
            pixel_addr = 16'b0;
      end
   
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            position_y <= 10'd240;
            state <= 3'b0;
            distance <= 9'd0;
        end
        else begin
            position_y <= next_position_y;
            state <= next_state;
            distance <= next_distance;
        end
    end      


    always@(*) begin
        case(state) 
            WAIT : begin
                next_position_y = 9'd240;
                next_distance = 9'd5;
                if(c_up) begin
                    next_state = MOTION;
                end
                else begin
                    next_state = WAIT;
                end
            end
            MOTION : begin 
                if(collision == 1'b1) begin
                    next_distance = distance;
                    next_position_y = position_y;
                    next_state = DROP;
                end
                else begin
                    if( (position_y - distance) >= 9'd20) begin
                        if(c_up) begin
                            next_distance = 9'd7;
                            next_position_y = position_y - 9'd12;
                            next_state = MOTION;
                        end
                        else begin
                            if(position_y - distance > 9'd419) begin
                                next_position_y = 9'd419;
                                next_distance = distance - 9'd1;
                                next_state = DROP;
                            end
                            else begin
                                next_position_y = position_y - distance;
                                next_distance = distance - 9'd1;
                                next_state = MOTION;
                            end
                        end
                    end
                    else begin
                        next_position_y = 9'd20;
                        next_state = DROP;
                        next_distance = distance;
                    end
                end
            end
            DROP : begin
                next_distance = distance;
                next_position_y = ((position_y + 4'd10 < 9'd419) ? position_y + 4'd10 : 9'd419);
                next_state = ((position_y != 9'd419) ? DROP : DEATH);
            end
            DEATH : begin
                if(restart) begin
                    next_distance = 9'd0;
                    next_position_y = 9'd240;
                    next_state = WAIT;
                end
                else begin
                    next_distance = 9'd0;
                    next_position_y = 9'd419;
                    next_state = DEATH;
                end
            end
        endcase
    end

endmodule


//module mem_addr_gen_Bird(
//   input clk,
//   input rst,
//   input [9:0] h_cnt,
//   input [9:0] v_cnt,
//   input c_up,
//   output reg [9:0] position_y,
//   output reg [16:0] pixel_addr
//   );
//   
//   reg [9:0] next_position_y;
//   reg [9:0] distance, next_distance;
//   reg [3:0] state, next_state;
//   parameter WAIT = 3'b000;
//   parameter MOTION = 3'b001;
//   parameter DEATH = 3'b010;
//   
//   
//   
//   always@(*) begin
//        if(h_cnt >= 80 && h_cnt < 120 && v_cnt >= (position_y % 480) && v_cnt < ((position_y + 40) % 480))
//            pixel_addr = (40 * (v_cnt - (position_y % 480)) + h_cnt - 9'd80 );
//        else
//            pixel_addr = 16'b0;
//      end
//   
//    always@(posedge clk or posedge rst) begin
//        if(rst) begin
//            position_y <= 10'd240;
//            state <= 3'b0;
//            distance <= 9'd0;
//        end
//        else begin
//            position_y <= next_position_y;
//            state <= next_state;
//            distance <= next_distance;
//        end
//    end      
//
//
//    always@(*) begin
//        case(state) 
//            WAIT : begin
//                next_position_y = 9'd240;
//                next_distance = 9'd5;
//                if(c_up) begin
//                    next_state = MOTION;
//                end
//                else begin
//                    next_state = WAIT;
//                end
//            end
//            MOTION : begin
//                if(position_y <= 9'd440) begin
//                    if(c_up) begin
//                        next_position_y = position_y - 9'd12;
//                        next_distance = 9'd11;
//                        next_state = MOTION;
//                    end
//                    else begin
//                        next_position_y = position_y - distance;
//                        next_distance = distance - 9'd1;
//                        next_state = MOTION;
//                    end
//                end
//                else begin
//                    if(position_y >= 10'd1000)
//                        next_position_y = 9'd0;
//                    else
//                        next_position_y = 9'd440;
//                    next_distance = distance;
//                    next_state = DEATH;
//                end
//            end
//            DEATH : begin
//                next_position_y = position_y;
//                next_distance = distance;
//                
//                if(c_up) begin
//                    next_state = WAIT;
//                end
//                else begin
//                    next_state = DEATH;
//                end
//            end
//        endcase
//    end
//
//endmodule


/*`timescale 1ns / 1ps

module mem_addr_gen_Bird(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input c_up,
   input [11:0] pipe_pixel,
   output reg [9:0] position_y,
   output reg [16:0] pixel_addr,
   output wire collision
   );
   
   wire [9:0] bird_right;
   wire signal_up, signal_down, signal_left, signal_right;
   
   reg [11:0] color_up, color_down, color_left, color_right;
   reg [9:0] next_position_y;
   reg [9:0] distance, next_distance;
   reg [3:0] state, next_state;
   parameter WAIT = 3'b000;
   parameter MOTION = 3'b001;
   parameter DEATH = 3'b010;
   
   assign bird_right = 9'd80;
   
   assign signal_up = ((h_cnt == 9'd100 && v_cnt == position_y - 9'd20) ? 0 : 1);
   assign signal_down = ((h_cnt == 9'd100 && v_cnt == position_y + 9'd20) ? 0 : 1);
   assign signal_left = ((h_cnt == 9'd80 && v_cnt == position_y) ? 0 : 1);
   assign signal_right = ((h_cnt == 9'd120 && v_cnt == position_y) ? 0 : 1);
   
   always@(posedge signal_up) color_up <= pipe_pixel;
   always@(posedge signal_down) color_down <= pipe_pixel;
   always@(posedge signal_left) color_left <= pipe_pixel;
   always@(posedge signal_right) color_right <= pipe_pixel;
   assign collision = ((color_up != 12'h534) || (color_down != 12'h534) || (color_left != 12'h534) || (color_right != 12'h534) );
   
   
   
   always@(*) begin
        if(h_cnt >= 80 && h_cnt < 120 && v_cnt >= ((position_y - 20) % 480) && v_cnt < ((position_y + 20) % 480))
            pixel_addr = (40 * (v_cnt - ((position_y - 20) % 480)) + h_cnt - 9'd80 );
        else
            pixel_addr = 16'b0;
      end
   
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            position_y <= 10'd240;
            state <= 3'b0;
            distance <= 9'd0;
        end
        else begin
            position_y <= next_position_y;
            state <= next_state;
            distance <= next_distance;
        end
    end      


    always@(*) begin
        case(state) 
            WAIT : begin
                next_position_y = 9'd240;
                next_distance = 9'd5;
                if(c_up) begin
                    next_state = MOTION;
                end
                else begin
                    next_state = WAIT;
                end
            end
            MOTION : begin 
                if(collision == 1'b1) begin
                    next_distance = distance;
                    next_position_y = position_y;
                    next_state = DEATH;
                end
                else begin
                    if( (position_y - distance) >= 9'd20) begin
                        if(c_up) begin
                            next_distance = 9'd11;
                            next_position_y = position_y - 9'd12;
                            next_state = MOTION;
                        end
                        else begin
                            if(position_y - distance > 9'd459) begin
                                next_position_y = 9'd459;
                                next_distance = distance - 9'd1;
                                next_state = DEATH;
                            end
                            else begin
                                next_position_y = position_y - distance;
                                next_distance = distance - 9'd1;
                                next_state = MOTION;
                            end
                        end
                    end
                    else begin
                        next_position_y = 9'd20;
                        next_state = DEATH;
                        next_distance = distance;
                    end
                end
            end
            DEATH : begin
                next_position_y = position_y;
                next_distance = distance;
                
                if(c_up) begin
                    next_state = WAIT;
                end
                else begin
                    next_state = DEATH;
                end
            end
        endcase
    end

endmodule
*/

//module mem_addr_gen_Bird(
//   input clk,
//   input rst,
//   input [9:0] h_cnt,
//   input [9:0] v_cnt,
//   input c_up,
//   output reg [9:0] position_y,
//   output reg [16:0] pixel_addr
//   );
//   
//   reg [9:0] next_position_y;
//   reg [9:0] distance, next_distance;
//   reg [3:0] state, next_state;
//   parameter WAIT = 3'b000;
//   parameter MOTION = 3'b001;
//   parameter DEATH = 3'b010;
//   
//   
//   
//   always@(*) begin
//        if(h_cnt >= 80 && h_cnt < 120 && v_cnt >= (position_y % 480) && v_cnt < ((position_y + 40) % 480))
//            pixel_addr = (40 * (v_cnt - (position_y % 480)) + h_cnt - 9'd80 );
//        else
//            pixel_addr = 16'b0;
//      end
//   
//    always@(posedge clk or posedge rst) begin
//        if(rst) begin
//            position_y <= 10'd240;
//            state <= 3'b0;
//            distance <= 9'd0;
//        end
//        else begin
//            position_y <= next_position_y;
//            state <= next_state;
//            distance <= next_distance;
//        end
//    end      
//
//
//    always@(*) begin
//        case(state) 
//            WAIT : begin
//                next_position_y = 9'd240;
//                next_distance = 9'd5;
//                if(c_up) begin
//                    next_state = MOTION;
//                end
//                else begin
//                    next_state = WAIT;
//                end
//            end
//            MOTION : begin
//                if(position_y <= 9'd440) begin
//                    if(c_up) begin
//                        next_position_y = position_y - 9'd12;
//                        next_distance = 9'd11;
//                        next_state = MOTION;
//                    end
//                    else begin
//                        next_position_y = position_y - distance;
//                        next_distance = distance - 9'd1;
//                        next_state = MOTION;
//                    end
//                end
//                else begin
//                    if(position_y >= 10'd1000)
//                        next_position_y = 9'd0;
//                    else
//                        next_position_y = 9'd440;
//                    next_distance = distance;
//                    next_state = DEATH;
//                end
//            end
//            DEATH : begin
//                next_position_y = position_y;
//                next_distance = distance;
//                
//                if(c_up) begin
//                    next_state = WAIT;
//                end
//                else begin
//                    next_state = DEATH;
//                end
//            end
//        endcase
//    end
//
//endmodule
