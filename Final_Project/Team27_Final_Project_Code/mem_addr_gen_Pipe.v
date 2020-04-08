module mem_addr_gen_Pipe(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [9:0] pipe1_x,
   output [9:0] up_pipe1_y,  
   output [9:0] down_pipe1_y,
   output [9:0] pipe2_x,
   output [9:0] up_pipe2_y,  
   output [9:0] down_pipe2_y,
   output reg [16:0] pipe_pixel_addr,
   
   input start, //signal for start the game
   input restart, //signal for restart the game
   input collision, //signal for stop the pipe and the game
   //score
   output [3:0] score0,
   output [3:0] score1,
   output [3:0] score2
   
   );
   //picture of pipe size is (70*480) 
   parameter [9:0] background_width = 10'd350,
                   background_height = 10'd480;                
   parameter [1:0] WAIT = 2'd0,
                   START = 2'd1,
                   STOP = 2'd2;
   reg [1:0] state, next_state; //for pipe1
   reg [1:0] State, next_State; //for pipe2
   reg activate; //activate the game
   
   reg [16:0] pipe1_x, next_pipe1_x;             
   reg [16:0] pipe2_x, next_pipe2_x;
   
   reg [3:0] score0, next_score0,
             score1, next_score1,
             score2, next_score2;
   always @ (posedge clk or posedge rst) begin
        if(rst)
            activate <= 1'b0;
        else if(start)
            activate <= 1'b1;
        else 
            activate <= activate;         
   end
   
   always @ (posedge clk or posedge rst) begin
       if(rst) begin
           state <= WAIT;
           State <= WAIT;
           pipe1_x <= 470;
           pipe2_x <= 470;
       end else begin
           state <= next_state;
           State <= next_State;
           pipe1_x <= next_pipe1_x;
           pipe2_x <= next_pipe2_x;
       end 
   end   
   
   always @(posedge clk or posedge rst) begin
        if(rst) begin
            score0 <= 4'd0;
            score1 <= 4'd0;
            score2 <= 4'd0;
        end else begin 
            score0 <= next_score0;
            score1 <= next_score1;
            score2 <= next_score2;
        end 
   end

   wire p2_move; //detect if pipe2 can move 
   reg [7:0] count, next_cnt;  // wait for pipe2
   //always @ (posedge clk or posedge rst) begin
   //     if(rst || !activate)
   //         count <= 0;
   //     else if(count == 8'b10111111)
   //         count <= count;
   //     else
   //         count <= count + 1;
   //end
   always @ (posedge clk or posedge rst) begin
        if(rst)
            count <= 0;
        else 
            count <= next_cnt;
    end
   
   assign p2_move = (count == 8'b10111111) ? 1'b1 : 1'b0;
     
   wire [7:0] Random1, Random2;
   reg freq1, freq2;
   always @ (*) begin
          if(pipe1_x == 470)  freq1 = 1;
          else  freq1 = 0;
          
          if(pipe2_x == 470)  freq2 = 1;
          else  freq2 = 0;
   end
   Random #(10101101) cut_pipe1_num(
        .clk(freq1),
        .rst(rst),
        .num(Random1)
   );
   Random #(10110101) cut_pipe2_num(
        .clk(freq2),
        .rst(rst),
        .num(Random2)
   );


   assign up_pipe1_y = Random1;
   assign down_pipe1_y = 160 + Random1;
   assign up_pipe2_y = Random2;    
   assign down_pipe2_y = 160 + Random2;

   always @ (*) begin //for pipe1 state
        case(state) 
        WAIT:
            if(activate) begin
                next_pipe1_x = pipe1_x - 1'b1;
                next_cnt = 8'd0;
                next_state = START;
            end else begin
                next_pipe1_x = pipe1_x;
                next_cnt = 8'd0;
                next_state = WAIT;
            end
        START: begin
            if(!collision) begin
                if(pipe1_x > 0) begin
                    next_pipe1_x = pipe1_x - 1'b1;
                    next_state = START;
                end else begin
                    next_pipe1_x = 470;
                    next_state = START;
                end
            end else begin
                next_pipe1_x = pipe1_x;
                next_state = STOP;
            end
            
            if(count == 8'b10111111)
                next_cnt = 8'b10111111;
            else
                next_cnt = count + 1'b1;
        end   
        STOP:       
            if(restart) begin
                next_pipe1_x = 470;
                next_cnt = 8'd0;
                next_state = WAIT;
            end else begin
                next_pipe1_x = pipe1_x;
                next_cnt = count;
                next_state = STOP;
            end
        endcase
   end
   
   always @ (*) begin //for pipe2 state
           case(State) 
           WAIT:
               if(activate && p2_move) begin
                   next_pipe2_x = pipe2_x - 1'b1;
                   next_State = START;
               end else begin
                   next_pipe2_x = pipe2_x;
                   next_State = WAIT;
               end
           START:
               if(!collision) begin
                   if(pipe2_x > 0) begin
                       next_pipe2_x = pipe2_x - 1'b1;
                       next_State = START;
                   end else begin
                       next_pipe2_x = 470;
                       next_State = START;
                   end
               end else begin
                   next_pipe2_x = pipe2_x;
                   next_State = STOP;
               end
           STOP:    
                if(restart) begin
                    next_pipe2_x = 470;
                    next_State = WAIT;
                end else begin
                    next_pipe2_x = pipe2_x;
                    next_State = STOP;
                end
           endcase
      end
   //counting and displaying the pipe1 and pipe2
   always@(*) begin
       if(h_cnt >= background_width)
            pipe_pixel_addr = 0;
       else if(h_cnt <= pipe1_x && h_cnt + 60 > pipe1_x) begin
            if(v_cnt <= Random1) // for up_pipe1
                pipe_pixel_addr = ((v_cnt + (0 + (480-Random1)))*60 + (h_cnt-pipe1_x));
            else if(v_cnt >= Random1+160 && v_cnt <= 480) //for down_pipe1
                pipe_pixel_addr = ((v_cnt - (0 + (Random1+160)))*60 + (h_cnt-pipe1_x));
            else begin 
                pipe_pixel_addr = 0;
            end
       end else if(p2_move) begin
           if(h_cnt <= pipe2_x && h_cnt + 60 > pipe2_x) begin
                if(v_cnt <= Random2) // for up_pipe2         
                    pipe_pixel_addr = ((v_cnt + (0 + (480-Random2)))*60 + (h_cnt-pipe2_x));
                else if(v_cnt >= Random2+160 && v_cnt <= 480) //for down_pipe2    
                    pipe_pixel_addr = ((v_cnt - (0 + (Random2+160)))*60 + (h_cnt-pipe2_x));
                else   
                    pipe_pixel_addr = 0;
           end else
                pipe_pixel_addr = 0;
       end else
            pipe_pixel_addr = 0;
   end
   
   //score user gets
   always @(*) begin
       if(state == STOP && State == STOP && restart) begin
            next_score0 = 4'd0;    
            next_score1 = 4'd0;    
            next_score2 = 4'd0;                     
       end else if(pipe1_x == 10'd120 || pipe2_x == 10'd120) begin
           if(score0 == 4'd9) begin
               if(score1 == 4'd9) begin
                   next_score0 = 4'd0;
                   next_score1 = 4'd0;
                   next_score2 = score2 + 1'b1; 
               end else begin
                   next_score0 = 4'd0;
                   next_score1 = score1 + 1'b1;
                   next_score2 = score2;
               end
           end else begin
               next_score0 = score0 + 1'b1;
               next_score1 = score1;
               next_score2 = score2;
           end            
       end else begin
           next_score0 = score0;
           next_score1 = score1;
           next_score2 = score2;
       end
   end 
   
endmodule
