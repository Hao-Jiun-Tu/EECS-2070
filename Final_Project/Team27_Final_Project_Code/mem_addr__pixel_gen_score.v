module mem_addr_gen_num0(
            input [9:0] h_cnt,
            input [9:0] v_cnt,
            input [3:0] score0,
            output reg [16:0] num0_pixel_addr
        ); 

    always @ (*) begin
        case(score0)
        4'd0: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*0);
              else
                    num0_pixel_addr =  16'd2999;   
        4'd1: if(h_cnt >= 169 && h_cnt < 180 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*1);
              else
                    num0_pixel_addr =  16'd2999; 
        4'd2: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*2);
              else
                    num0_pixel_addr =  16'd2999; 
        4'd3: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*3);
              else 
                    num0_pixel_addr =  16'd2999; 
        4'd4: if(h_cnt >= 163 && h_cnt < 174 && v_cnt >= 70 && v_cnt < 97) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*4);
              else if(h_cnt >= 174 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104)
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*7);      
              else 
                    num0_pixel_addr =  16'd2999; 
        4'd5: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*5);
              else 
                    num0_pixel_addr =  16'd2999; 
        4'd6: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*6);
              else 
                    num0_pixel_addr =  16'd2999; 
        4'd7: if(h_cnt >= 163 && h_cnt < 174 && v_cnt >= 70 && v_cnt < 91) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*7);
              else if(h_cnt >= 174 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104)
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*7);
              else
                    num0_pixel_addr = 16'd2999; 
        4'd8: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*8);
              else 
                    num0_pixel_addr =  16'd2999; 
        4'd9: if(h_cnt >= 163 && h_cnt < 184 && v_cnt >= 70 && v_cnt < 104) 
                    num0_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 80 + 15*9);
              else 
                    num0_pixel_addr =  16'd2999; 
        default: num0_pixel_addr =  16'd2999; 
        endcase
    end   

endmodule

module mem_addr_gen_num1(
            input [9:0] h_cnt,
            input [9:0] v_cnt,
            input [3:0] score1,
            output reg [16:0] num1_pixel_addr
        ); 
        
    always @ (*) begin
            case(score1)
            4'd0: num1_pixel_addr =  16'd2999;   
            4'd1: if(h_cnt >= 139 && h_cnt < 150 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*1);
                  else
                        num1_pixel_addr =  16'd2999; 
            4'd2: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*2);
                  else
                        num1_pixel_addr =  16'd2999;
            4'd3: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*3);
                  else 
                        num1_pixel_addr = 16'd2999;
            4'd4: if(h_cnt >= 133 && h_cnt < 144 && v_cnt >= 70 && v_cnt < 97) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*4);
                  else if(h_cnt >= 144 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104)
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*7);      
                  else 
                        num1_pixel_addr = 16'd2999;
            4'd5: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*5);
                  else 
                        num1_pixel_addr = 16'd2999;
            4'd6: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*6);
                  else 
                        num1_pixel_addr = 16'd2999;
            4'd7: if(h_cnt >= 133 && h_cnt < 144 && v_cnt >= 70 && v_cnt < 91) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*7);
                  else if(h_cnt >= 144 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104)
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*7);
                  else
                        num1_pixel_addr = 16'd2999;
            4'd8: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*8);
                  else 
                        num1_pixel_addr = 16'd2999;
            4'd9: if(h_cnt >= 133 && h_cnt < 154 && v_cnt >= 70 && v_cnt < 104) 
                        num1_pixel_addr = ((v_cnt >> 1) - 35)* 150 - 1 + ((h_cnt >> 1) - 65 + 15*9);
                  else 
                        num1_pixel_addr = 16'd2999;
            default: num1_pixel_addr = 16'd2999;
            endcase
        end      

endmodule

module score_pixel_gen(
       input [9:0] h_cnt, 
       input [9:0] v_cnt,
       input [11:0] num0_pixel,
       input [11:0] num1_pixel,
       output reg [11:0] score_pixel
    );    
    
    always @ (*) begin
        if(h_cnt >= 160 && h_cnt < 190 && v_cnt >= 70 && v_cnt < 110)
            score_pixel = num0_pixel;
        else if(h_cnt >= 130 && h_cnt < 160 && v_cnt >= 70 && v_cnt < 110) 
            score_pixel = num1_pixel;
        else
            score_pixel = num0_pixel;
    end
endmodule