module mem_addr_gen_gameover(
        input clk,
        input rst,
        input [9:0] h_cnt,
        input [9:0] v_cnt,
        input start,
        input restart,
        input stop,
        output reg [16:0] gameover_pixel_addr,
        output gameover
    );   
    parameter  WAIT = 1'b0,
               STOP = 1'b1;
                    
    reg state, next_state;
    
    assign gameover = (state == WAIT) ? 1'b0 : 1'b1;
    
    always @ (posedge clk or posedge rst) begin
        if(rst)
            state <= WAIT;
        else 
            state <= next_state;
    end
    
    always @ (*) begin
        case(state)
        WAIT:
            if(stop)
                next_state = STOP;
            else
                next_state = WAIT;
        STOP:
            if(restart || rst)
                next_state = WAIT;
            else
                next_state = STOP;
        endcase
    end
    
    always @ (*) begin
        if(h_cnt >= 114 && h_cnt < 236 && v_cnt >= 150 && v_cnt < 180)
            gameover_pixel_addr = (v_cnt - 150) * 120 - 1 + (h_cnt - 112);
        else
            gameover_pixel_addr = 0;
    end

    
endmodule
