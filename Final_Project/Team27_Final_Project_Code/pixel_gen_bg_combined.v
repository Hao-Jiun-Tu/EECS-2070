module pixel_gen_bg_combined0(
        input [9:0] h_cnt,
        input [9:0] v_cnt,
        
        input [11:0] background_pixel,

        input [11:0] pipe_pixel,
        input [9:0] pipe1_x,                      
        input [9:0] up_pipe1_y,      
        input [9:0] down_pipe1_y,  
                                      
        input [9:0] pipe2_x,                      
        input [9:0] up_pipe2_y,      
        input [9:0] down_pipe2_y,  

        input gameover,
        input [11:0] gameover_pixel,
        
        output reg [11:0] combined0_bg_pixel 
    );
    
    always @ (*) begin
            if(v_cnt >= 440 || h_cnt >= 350) begin
                     combined0_bg_pixel = background_pixel;
            end else if(gameover && h_cnt >= 114 && h_cnt < 236 && v_cnt >= 150 && v_cnt < 180) begin
                combined0_bg_pixel = gameover_pixel;
            end else if(h_cnt <= pipe1_x && h_cnt + 60 > pipe1_x) begin
                if(v_cnt <= up_pipe1_y || v_cnt >= down_pipe1_y)
                    combined0_bg_pixel = pipe_pixel;
                else 
                    combined0_bg_pixel = background_pixel;
            end else if(h_cnt <= pipe2_x && h_cnt + 60 > pipe2_x) begin
                if(v_cnt <= up_pipe2_y || v_cnt >= down_pipe2_y)
                    combined0_bg_pixel = pipe_pixel;
                else 
                    combined0_bg_pixel = background_pixel;
            end else
                combined0_bg_pixel = background_pixel;
    end
endmodule
