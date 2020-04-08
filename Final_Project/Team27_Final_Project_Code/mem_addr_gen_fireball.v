module mem_addr_gen_fireball(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input gogacu,
   input [9:0] position_y,
   output reg [16:0] pixel_addr,
   output reg gogacu_signal
    );
    
   reg [1:0] state, next_state;
   reg [6:0] times, next_times;
   parameter WAIT = 2'b00;
   parameter FIRE = 2'b01;
   
   
   always@(posedge clk) begin
        if(rst) begin
            state <= WAIT;
            times <= 5'd0;
        end
        else begin
            state <= next_state;
            times <= next_times;
        end
   end
   
   always@(*) begin
        case(state) 
            WAIT : begin
                gogacu_signal = 1'b0;
                if(gogacu) begin
                    next_times = 9'd100;
                    next_state = FIRE;
                end
                else begin
                    next_times = 9'd0;
                    next_state = WAIT;
                end
            end
            FIRE : begin
                gogacu_signal = 1'b1;
                if(times > 1'b0) begin
                    next_times = times - 1'b1;
                    next_state = FIRE;
                end
                else begin
                    next_times = times;
                    next_state = WAIT;
                end
            end
        endcase
   end
   
   always@(*) begin
        if(h_cnt >= 120 && h_cnt < 320 && v_cnt >= ((position_y - 56) % 480) && v_cnt < ((position_y + 56) % 480) && (times % 9'd2 == 1'b1))
            pixel_addr = (200 * (v_cnt - ((position_y - 56) % 480)) + h_cnt - 9'd120 );
        else
            pixel_addr = 16'b0;
      end


endmodule

