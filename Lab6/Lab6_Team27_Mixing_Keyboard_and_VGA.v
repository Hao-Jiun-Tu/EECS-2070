module top(
   input clk,
   input rst,
   input PS2_DATA,
   input PS2_CLK,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync
    );
    wire [3:0] key;
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

  assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;
  
  
     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22)
    );
    
    
   SampleDisplay U66(
    .data(key),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .rst(rst),
    .clk(clk)
 );


    mem_addr_gen mem_addr_gen_inst(
    .clk(clk_22),
    .rst(rst),
    .key(key),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .pixel_addr(pixel_addr)
    );
     
 
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(pixel)
    ); 

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
endmodule

module clock_divisor(clk1, clk, clk22);
input clk;
output clk1;
output clk22;
reg [21:0] num;
wire [21:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];
endmodule

module mem_addr_gen(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input [3:0] key,
   output [16:0] pixel_addr
   );
    
   reg [9:0] position_x;
   reg [9:0] next_position_x;
   reg [9:0] position_y;
   reg [9:0] next_position_y;
   reg direction_x, direction_y;
   reg next_direction_x, next_direction_y;
   wire op_key_h, op_key_v, debounce_h, debounce_v;
   wire v_flip, h_flip;
   
   reg [2:0] state, next_state;
    
  
    assign pixel_addr = 
   (direction_x == 1'b0 && direction_y == 1'b0)? (320*((v_cnt>>1)+position_y)+((h_cnt>>1)+position_x)%320)% 76800 :
   (direction_x == 1'b1 && direction_y == 1'b0)? (320*((v_cnt>>1)+position_y)+320-((h_cnt>>1)+position_x)%320)% 76800 :
   (direction_x == 1'b0 && direction_y == 1'b1)? (320*(240-((v_cnt>>1)+position_y)%240)+((h_cnt>>1)+position_x)%320)% 76800 :
   76800-((320*((v_cnt>>1)+position_y)+((h_cnt>>1)+position_x)%320)% 76800);
   
   parameter pause = 3'b000;
   parameter row_up = 3'b001;
   parameter row_down = 3'b010;
   parameter row_left = 3'b011;
   parameter row_right = 3'b100;
   parameter v_pressed = 3'b101;
   parameter h_pressed = 3'b110;
    

    assign v_flip = ((key == v_pressed) ? 1'b1 : 1'b0);
    assign h_flip = ((key == h_pressed) ? 1'b1 : 1'b0);
    
    always @ (posedge v_flip) next_direction_x = ~direction_x; 
    always @ (posedge h_flip) next_direction_y = ~direction_y; 

   always @ (posedge clk or posedge rst) begin
      if(rst) begin
          position_y <= 1'b0;
          position_x <= 1'b0;
          direction_x <= 1'b0;
          direction_y <= 1'b0;
          state <= 3'b000;
      end
      else begin
            position_y <= next_position_y;
            position_x <= next_position_x;
            direction_x <= next_direction_x;
            direction_y <= next_direction_y;
            state <= next_state;
           /* 
           if(position_x < 319)
               position_x <= position_x + 1'b1;
           else
               position_x <= 1'b0;
               */
      end
   end
   
   
   always@* begin
        case(state)
            pause : begin
                case(key)
                    row_up : next_state = row_up;
                    row_down : next_state = row_down;
                    row_left : next_state = row_left;
                    row_right : next_state = row_right;
                    default : next_state = pause;
                endcase
                next_position_x = position_x;
                next_position_y = position_y;
            end
            
            row_left : begin
                case(key)
                    row_up : next_state = row_up;
                    row_down : next_state = row_down;
                    row_right : next_state = row_right;
                    pause : next_state = pause;
                    default : next_state = row_left;
                endcase
               if(position_x < 319)
                   next_position_x = position_x + 1'b1;
               else
                   next_position_x = 1'b0;
                next_position_y = position_y;
            end
            
            row_right : begin
                case(key)
                    row_up : next_state = row_up;
                    row_down : next_state = row_down;
                    row_left : next_state = row_left;
                    pause : next_state = pause;
                    default : next_state = row_right;
                endcase
                if(position_x > 0)
                   next_position_x = position_x - 1'b1;
               else
                   next_position_x = 9'd319;
                next_position_y = position_y;
            end
            
            row_up : begin
                case(key)
                    row_left : next_state = row_left;
                    row_down : next_state = row_down;
                    row_right : next_state = row_right;
                    pause : next_state = pause;
                    default : next_state = row_up;
                endcase
               if(position_y < 9'd239)
                   next_position_y = position_y + 1'b1;
               else
                   next_position_y = 1'b0;
               next_position_x = position_x;
            end
            
            row_down : begin
                case(key)
                    row_up : next_state = row_up;
                    row_right : next_state = row_right;
                    row_left : next_state = row_left;
                    pause : next_state = pause;
                    default : next_state = row_down;
                endcase
                if(position_y > 0)
                   next_position_y = position_y - 1'b1;
                else
                   next_position_y = 9'd239;
                next_position_x = position_x;
            end
            
            default : begin
                next_state = pause;
                next_position_x = position_x;
                next_position_y = position_y;
            end 
            
        endcase   
   end   
   
    
endmodule

module SampleDisplay(
    output [3:0] data,
 inout wire PS2_DATA,
 inout wire PS2_CLK,
 input wire rst,
 input wire clk
 );
 
 reg [18:0] clk_dick;
 
 always @(posedge clk) clk_dick <= clk_dick + 1'b1;
 
 parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
 parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
 parameter [8:0] KEY_CODES [0:6] = { 
  9'b0_0100_1101, // pause
  9'b0_0111_0101, // row_up
  9'b0_0111_0010, // row_down
  9'b1_0110_1011, // row_left
  9'b0_0111_0100, // row_right
  9'b0_0010_1010,   // v_flip
  9'b0_0011_0011    // h_flip
 };
 
 reg [15:0] nums;
 reg [3:0] key_num;
 reg [9:0] last_key;
 
 wire shift_down;
 wire [511:0] key_down;
 wire [8:0] last_change;
 wire been_ready;
 wire is_extend;
 
 assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;

 KeyboardDecoder key_de (
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(been_ready),
  .PS2_DATA(PS2_DATA),
  .PS2_CLK(PS2_CLK),
  .is_extend(is_extend),
  .rst(rst),
  .clk(clk)
 );

 always @ (posedge clk) begin
  if (rst) begin
   nums <= 16'b0;
  end else begin
                nums <= nums;
                if (been_ready && key_down[last_change] == 1'b1) begin
                    if (key_num != 4'b1111)begin
                        nums <= {{nums[11:8]} , key_num};
                    end
                end
  end
 end
 assign data = {nums[3:0]};
 
 always @ (*) begin
  case (last_change)
   KEY_CODES[00] : key_num = 4'b0000;
   KEY_CODES[01] : key_num = 4'b0001;
   KEY_CODES[02] : key_num = 4'b0010;
   KEY_CODES[03] : key_num = 4'b0011;
   KEY_CODES[04] : key_num = 4'b0100;
   KEY_CODES[05] : key_num = 4'b0101;
   KEY_CODES[06] : key_num = 4'b0110;
   default    : key_num = 4'b1111;
  endcase
 end
 
endmodule

module KeyboardDecoder(
	output reg [511:0] key_down,
	output wire [8:0] last_change,
	output reg key_valid,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
	parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state;
    reg been_ready, been_extend, been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
		.key_in(key_in),
		.is_extend(is_extend),
		.is_break(is_break),
		.valid(valid),
		.err(err),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
	
	OnePulse op (
		.signal_single_pulse(pulse_been_ready),
		.signal(been_ready),
		.clock(clk)
	);
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		state <= INIT;
    		been_ready  <= 1'b0;
    		been_extend <= 1'b0;
    		been_break  <= 1'b0;
    		key <= 10'b0_0_0000_0000;
    	end else begin
    		state <= state;
			been_ready  <= been_ready;
			been_extend <= (is_extend) ? 1'b1 : been_extend;
			been_break  <= (is_break ) ? 1'b1 : been_break;
			key <= key;
    		case (state)
    			INIT : begin
    					if (key_in == IS_INIT) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready  <= 1'b0;
							been_extend <= 1'b0;
							been_break  <= 1'b0;
							key <= 10'b0_0_0000_0000;
    					end else begin
    						state <= INIT;
    					end
    				end
    			WAIT_FOR_SIGNAL : begin
    					if (valid == 0) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready <= 1'b0;
    					end else begin
    						state <= GET_SIGNAL_DOWN;
    					end
    				end
    			GET_SIGNAL_DOWN : begin
						state <= WAIT_RELEASE;
						key <= {been_extend, been_break, key_in};
						been_ready  <= 1'b1;
    				end
    			WAIT_RELEASE : begin
    					if (valid == 1) begin
    						state <= WAIT_RELEASE;
    					end else begin
    						state <= WAIT_FOR_SIGNAL;
    						been_extend <= 1'b0;
    						been_break  <= 1'b0;
    					end
    				end
    			default : begin
    					state <= INIT;
						been_ready  <= 1'b0;
						been_extend <= 1'b0;
						been_break  <= 1'b0;
						key <= 10'b0_0_0000_0000;
    				end
    		endcase
    	end
    end
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		key_valid <= 1'b0;
    		key_down <= 511'b0;
    	end else if (key_decode[last_change] && pulse_been_ready) begin
    		key_valid <= 1'b1;
    		if (key[8] == 0) begin
    			key_down <= key_down | key_decode;
    		end else begin
    			key_down <= key_down & (~key_decode);
    		end
    	end else begin
    		key_valid <= 1'b0;
			key_down <= key_down;
    	end
    end

endmodule

module OnePulse (
	output reg signal_single_pulse,
	input wire signal,
	input wire clock
	);
	
	reg signal_delay;

	always @(posedge clock) begin
		if (signal == 1'b1 & signal_delay == 1'b0)
		  signal_single_pulse <= 1'b1;
		else
		  signal_single_pulse <= 1'b0;

		signal_delay <= signal;
	end
endmodule

