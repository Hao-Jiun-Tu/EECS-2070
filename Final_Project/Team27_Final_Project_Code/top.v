module top(
   input clk,
   input rst,
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue,
   output hsync,
   output vsync,
   inout wire PS2_DATA,
   inout wire PS2_CLK,
   output [6:0] seg,
   output [3:0] an,
   
   input [3:0] level_sw,
   output reg [3:0] game_level
    );

    wire [11:0] data;
    wire clk_25MHz;
    wire clk_14, clk_15;
    wire clk_18, clk_19, clk_20, clk_21, clk_22;
    wire [1:0] stcl;
    assign stcl = {clk_15, clk_14};
    
    wire [11:0] pixel;
    wire [11:0] bird_pixel; 
    wire [11:0] pipe_pixel;
    wire [11:0] ground_pixel;
    wire [11:0] cloud_pixel;
    wire [11:0] num0_pixel;
    wire [11:0] num1_pixel;
    wire [11:0] score_pixel;
    wire [11:0] background_pixel;
    wire [11:0] combined0_bg_pixel;
    wire [11:0] combined1_bg_pixel; 
    wire [11:0] fireball_pixel; 
    wire [11:0] gameover_pixel;
    
    wire [16:0] pipe_pixel_addr;
    wire [16:0] bird_pixel_addr;
    wire [16:0] ground_pixel_addr;
    wire [16:0] cloud_pixel_addr;
    wire [16:0] num0_pixel_addr;
    wire [16:0] num1_pixel_addr;
    wire [16:0] fireball_pixel_addr;
    wire [16:0] gameover_pixel_addr;
    
    wire gogacu_signal;
    
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire [9:0] bird_position_y;
    
    wire collision; // game stopping siganl
    wire gameover;
    
    Clock_Divider #(.n(14)) c14(clk, clk_14); 
    Clock_Divider #(.n(15)) c15(clk, clk_15);  
    Clock_Divider #(.n(18)) c18(clk, clk_18); 
    Clock_Divider #(.n(19)) c19(clk, clk_19);  
    Clock_Divider #(.n(20)) c20(clk, clk_20);
    Clock_Divider #(.n(21)) c21(clk, clk_21);
    
    clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22)
    );
    
    wire d_pause, d_rst, d_gogacu, d_restart;
    wire od_pause, od_rst, od_gogacu, od_restart;

    debounce U0(.pb_debounced(d_rst), .pb(rst), .clk(clk_22));
    onepulse U1(.PB_debounced(d_rst), .clk(clk_22), .PB_one_pulse(od_rst));
    
    wire pause = (key_valid == 1'b0 && key_down[9'h75] == 1'b1); // key_a 2'h4D  
    wire gogacu = (key_valid == 1'b0 && key_down[9'h74] == 1'b1); 
    wire restart = (key_valid == 1'b0 && key_down[9'h73] == 1'b1); 
    
    debounce U2(.pb_debounced(d_pause), .pb(pause), .clk(clk_18));  
    debounce U3(.pb_debounced(d_gogacu), .pb(gogacu), .clk(clk_18));
    debounce U4(.pb_debounced(d_restart), .pb(restart), .clk(clk_18));  
    onepulse U5(.PB_debounced(d_pause), .clk(clk_18), .PB_one_pulse(od_pause));
    onepulse U6(.PB_debounced(d_gogacu), .clk(clk_18), .PB_one_pulse(od_gogacu));
    onepulse U7(.PB_debounced(d_restart), .clk(clk_18), .PB_one_pulse(od_restart));
    
    //clock expander
    wire new_pause;
    wire new_restart;
    
    clk_expander U77(.in(od_pause), .clk_q(clk_18), .out(new_pause));
    clk_expander U78(.in(od_gogacu), .clk_q(clk_18), .out(new_gogacu));
    clk_expander U79(.in(od_restart), .clk_q(clk_18), .out(new_restart));
    
    KeyboardDecoder key_de (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(od_rst),
        .clk(clk)
    );
    
    //The following is for pipe    Pipe --> 60*480
    wire [9:0] pipe1_x;       
    wire [9:0] pipe2_x;       
    wire [9:0] up_pipe1_y;
    wire [9:0] down_pipe1_y;
    wire [9:0] up_pipe2_y;
    wire [9:0] down_pipe2_y;
    
    wire [3:0] score0;
    wire [3:0] score1;
    wire [3:0] score2;
    
    reg pipe_clk;
    wire p_clk;
    Pipe_clk_div pipe_freq(.clk(clk), .clk_div(p_clk));
       
    always @ (*) begin
        if(level_sw[3]) begin
            pipe_clk = clk_18;
            game_level = 4'b1111;
        end else if(level_sw[2]) begin
            pipe_clk = clk_19;
            game_level = 4'b0111;
        end else if(level_sw[1]) begin
            pipe_clk = clk_20;
            game_level = 3'b0011;
        end else if(level_sw[0]) begin
            pipe_clk = clk_21;
            game_level = 3'b0001;
        end else if(score1 > 4'd4) begin
            pipe_clk = clk_18;
            game_level = 3'b1111;
        end else if(score1 > 4'd2) begin
            pipe_clk = clk_19;
            game_level = 3'b0111;
        end else if(score1 > 4'd0) begin
            pipe_clk = p_clk;
            game_level = 3'b0011;
        end else begin
            pipe_clk = clk_20;
            game_level = 3'b0001;
        end
    end
    mem_addr_gen_Pipe Pipe(
        .clk(pipe_clk),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pipe1_x(pipe1_x),       
        .up_pipe1_y(up_pipe1_y),  
        .down_pipe1_y(down_pipe1_y),
              
        .pipe2_x(pipe2_x),       
        .up_pipe2_y(up_pipe2_y),     
        .down_pipe2_y(down_pipe2_y),        
        .pipe_pixel_addr(pipe_pixel_addr),
        
        .start(new_pause), //new_pause --> bird jumping signal --> game starting signal
        .collision(collision), //game stopping signal
        .restart(new_restart),
        
        .score0(score0),
        .score1(score1),
        .score2(score2)
    );
    
    mem_addr_gen_Bird Bird( //Bird-->40*40
        .clk(clk_21),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .c_up(new_pause),
        .restart(new_restart),
        .pipe_pixel(pipe_pixel),
        .pixel_addr(bird_pixel_addr),
        .position_y(bird_position_y),
        .gogacu_signal(gogacu_signal),
        .collision(collision) //game stopping signal
    ); 
    
    mem_addr_gen_fireball fire(
        .clk(clk_21),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .gogacu(new_gogacu),
        .position_y(bird_position_y),
        .pixel_addr(fireball_pixel_addr),
        .gogacu_signal(gogacu_signal)
    ); 
    
    mem_addr_gen_Ground_Cloud Ground_Cloud(
        .clk(pipe_clk),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .ground_pixel_addr(ground_pixel_addr),
        .cloud_pixel_addr(cloud_pixel_addr),
        .start(new_pause),
        .restart(restart),
        .gameover(gameover)
    );
    
    mem_addr_gen_num0 Num0(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .score0(score0),
        .num0_pixel_addr(num0_pixel_addr)
    ); 
    
    mem_addr_gen_num1 Num1(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .score1(score1),
        .num1_pixel_addr(num1_pixel_addr)
    );
    
    mem_addr_gen_gameover GameOver(
        .clk(clk_21),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .restart(new_restart),
        .stop(collision),
        .gameover_pixel_addr(gameover_pixel_addr),
        .gameover(gameover)
    );

    blk_mem_gen_0 blk_mem_gen_Pipe(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pipe_pixel_addr),
      .dina(data[11:0]),
      .douta(pipe_pixel)
    ); 
    
    blk_mem_gen_1 blk_mem_gen_Bird(
      .clka(clk_25MHz),
      .wea(0),
      .addra(bird_pixel_addr),
      .dina(data[11:0]),
      .douta(bird_pixel)
    );
    
    blk_mem_gen_2 blk_mem_gen_Ground(
        .clka(clk_25MHz),
        .wea(0),
        .addra(ground_pixel_addr),
        .dina(data[11:0]),
        .douta(ground_pixel)
    );
    
    blk_mem_gen_3 blk_mem_gen_Cloud(
        .clka(clk_25MHz),
        .wea(0),
        .addra(cloud_pixel_addr),
        .dina(data[11:0]),
        .douta(cloud_pixel)
    );
    
    blk_mem_gen_4 blk_mem_gen_Num0(
        .clka(clk_25MHz),
        .wea(0),
        .addra(num0_pixel_addr),
        .dina(data[11:0]),
        .douta(num0_pixel)
    );
    
    blk_mem_gen_4 blk_mem_gen_Num1(
        .clka(clk_25MHz),
        .wea(0),
        .addra(num1_pixel_addr),
        .dina(data[11:0]),
        .douta(num1_pixel)
    );

    blk_mem_gen_5 blk_mem_gen_fireball(
        .clka(clk_25MHz),
        .wea(0),
        .addra(fireball_pixel_addr),
        .dina(data[11:0]),
        .douta(fireball_pixel)
    );    
    
    blk_mem_gen_6 blk_mem_gen_gameover(
        .clka(clk_25MHz),
        .wea(0),
        .addra(gameover_pixel_addr),
        .dina(data[11:0]),
        .douta(gameover_pixel)
    );
        
    pixel_gen_Background Background(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .ground_pixel(ground_pixel),
        .cloud_pixel(cloud_pixel),
        .background_pixel(background_pixel)
    ); 
    
    score_pixel_gen Score(
       .h_cnt(h_cnt),
       .v_cnt(v_cnt),
       .num0_pixel(num0_pixel),
       .num1_pixel(num1_pixel),
       .score_pixel(score_pixel)
    );     
    
    pixel_gen_bg_combined0 Combine0(   // combined with background and pipes
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        
        .background_pixel(background_pixel),
        
        .pipe_pixel(pipe_pixel),
        .pipe1_x(pipe1_x),                      
        .up_pipe1_y(up_pipe1_y),      
        .down_pipe1_y(down_pipe1_y),  
                                                
        .pipe2_x(pipe2_x),                      
        .up_pipe2_y(up_pipe2_y),      
        .down_pipe2_y(down_pipe2_y),
        
        .gameover(gameover),
        .gameover_pixel(gameover_pixel),  
        
        .combined0_bg_pixel(combined0_bg_pixel) 
    );
     
    seven_seg segs(
        .stcl(stcl),
        .score0(score0),
        .score1(score1),
        .score2(score2),
        .seg(seg),
        .an(an)
    );

    vga_controller  vga_inst(
        .pclk(clk_25MHz),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );
    
    //For Screen Coloring
    always@(*) begin
          if(h_cnt >= 120 && h_cnt < 320 && v_cnt >= ((bird_position_y - 56) % 480) && v_cnt < ((bird_position_y + 56) % 480) && fireball_pixel != 12'b0) begin
                      {vgaRed, vgaGreen, vgaBlue} = (valid == 1'b1) ? fireball_pixel : 12'h0;
          end else begin
              if(h_cnt >= 80 && h_cnt < 120 && v_cnt >= ((bird_position_y - 20) % 480) && v_cnt < ((bird_position_y + 20) % 480)) begin
                  if(bird_pixel == 12'b0) begin
                      {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? combined0_bg_pixel:12'h0;
                  end else
                      {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? bird_pixel:12'h0;
              end else if(h_cnt >= 130 && h_cnt < 190 && v_cnt >= 70 && v_cnt < 110) begin
                  if(score_pixel == 12'he12)
                      {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? combined0_bg_pixel:12'h0;
                  else
                      {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? score_pixel:12'h0;
              end else
                  {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? combined0_bg_pixel:12'h0;
          end
    end

endmodule
