module mem_addr_gen_Ground_Cloud (
       input clk,
       input rst,
       input [9:0] h_cnt,
       input [9:0] v_cnt,
       output reg [16:0] ground_pixel_addr,
       output reg [16:0] cloud_pixel_addr,
       
       input start,
       input restart,
       input gameover
    );
    
   //for ground
    reg [9:0] ground_x;
    always @ (posedge clk or posedge rst) begin
        if(rst)
            ground_x <= 0;
        else if(gameover)
            ground_x <= ground_x;
        else if(ground_x == 349)
            ground_x <= 0;
        else 
            ground_x <= ground_x + 1'b1;
    end
    
    always @ (*) begin
        if(v_cnt >= 10'd440 && v_cnt < 10'd455) begin
            if(h_cnt <= 10'd349)
                ground_pixel_addr = ((v_cnt - 440)*350 - 1  + h_cnt + ground_x);
            else
                ground_pixel_addr = 0;
        end else
            ground_pixel_addr = 0;
    end
    
    //for cloud
   always @ (*) begin
         if(v_cnt >= 320 && v_cnt < 440) begin
             if(h_cnt < 350)
                 cloud_pixel_addr = (((v_cnt >> 1) - 160) * 175 - 1 + (h_cnt>>1));
             else 
                 cloud_pixel_addr = 0;
         end else 
             cloud_pixel_addr = 0;
     end
    
endmodule
