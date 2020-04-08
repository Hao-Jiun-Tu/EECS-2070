module pixel_gen_Background (
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input [11:0] ground_pixel,
    input [11:0] cloud_pixel,
    output reg [11:0] background_pixel
    ); 
    
    always @ (*) begin
        if(v_cnt < 320 && h_cnt < 350)
            background_pixel = 12'h4cc;
        else if(v_cnt >= 320 && v_cnt < 440 && h_cnt < 350)
            background_pixel = cloud_pixel;
        else if(v_cnt >= 440 && v_cnt < 455 && h_cnt < 350)
            background_pixel = ground_pixel;
        else if(h_cnt < 350)
            background_pixel = 12'hdd9;
        else
            background_pixel = 0;    
    end
    
endmodule
