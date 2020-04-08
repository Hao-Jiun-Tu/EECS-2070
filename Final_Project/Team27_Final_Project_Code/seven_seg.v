module seven_seg (
    input [1:0] stcl,
    input [3:0] score0,
    input [3:0] score1,
    input [3:0] score2,
    output reg [6:0] seg,
    output reg [3:0] an
    );            
    reg [6:0] seg0, seg1, seg2;
    
    always @(*) begin
        case(score0)
            4'd0 : seg0 = 7'b1000000;
            4'd1 : seg0 = 7'b1111001;
            4'd2 : seg0 = 7'b0100100;
            4'd3 : seg0 = 7'b0110000;
            4'd4 : seg0 = 7'b0011001;
            4'd5 : seg0 = 7'b0010010;
            4'd6 : seg0 = 7'b0000010;
            4'd7 : seg0 = 7'b1011000;
            4'd8 : seg0 = 7'b0000000;
            4'd9 : seg0 = 7'b0011000;
            default : seg0 = 7'b1111111;
        endcase
    end
    
    always @(*) begin
        case(score1)
            4'd0 : seg1 = 7'b1000000;
            4'd1 : seg1 = 7'b1111001;
            4'd2 : seg1 = 7'b0100100;
            4'd3 : seg1 = 7'b0110000;
            4'd4 : seg1 = 7'b0011001;
            4'd5 : seg1 = 7'b0010010;
            4'd6 : seg1 = 7'b0000010;
            4'd7 : seg1 = 7'b1011000;
            4'd8 : seg1 = 7'b0000000;
            4'd9 : seg1 = 7'b0011000;
            default : seg1 = 7'b1111111;
        endcase
    end
    
    always @(*) begin
        case(score2)
            4'd0 : seg2 = 7'b1000000;
            4'd1 : seg2 = 7'b1111001;
            4'd2 : seg2 = 7'b0100100;
            4'd3 : seg2 = 7'b0110000;
            4'd4 : seg2 = 7'b0011001;
            4'd5 : seg2 = 7'b0010010;
            4'd6 : seg2 = 7'b0000010;
            4'd7 : seg2 = 7'b1011000;
            4'd8 : seg2 = 7'b0000000;
            4'd9 : seg2 = 7'b0011000;
            default : seg2 = 7'b1111111;
        endcase
    end

    always @(*) begin
        case(stcl)
            2'd0: seg = seg0;   
            2'd1: seg = seg1;
            2'd2: seg = seg2;
            2'd3: seg = seg0;
        endcase
    end
    
    always @(*) begin
        case(stcl)
            2'd0: an = 4'b1110;   
            2'd1: an = 4'b1101;
            2'd2: an = 4'b1011;
            2'd3: an = 4'b1111;
        endcase
    end        
endmodule