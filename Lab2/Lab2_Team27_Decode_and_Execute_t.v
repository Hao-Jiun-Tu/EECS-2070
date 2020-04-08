`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/02 15:11:45
// Design Name: 
// Module Name: test_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module test_decoder;
reg [2:0] s;
reg [3:0] rs, rt;
reg err, CLK;
wire [3:0] rd;

Decode_and_Execute U0(
    .op_code(s),
    .rs(rs),
    .rt(rt),
    .rd(rd)
);

// simulate a clock with 5ns on-time and 5ns off-time 
always #1 CLK = ~CLK;
initial CLK = 1'b1;

initial begin
    {s, rs, rt} = 11'b11000000000;
    
    repeat (2 ** 11) begin
	@ (posedge CLK)
		 Test;
    @ (negedge CLK)
		 {s, rs, rt} =  {s, rs, rt} + 1'b1;
  end
     $finish;
end


task Test;
begin
        if(s == 3'b000) begin
            if(rd ==  rs + rt) begin
                err =  1'b0;
            end
            else begin
                err = 1'b1;
            end
        end
        else if(s == 3'b001) begin
            if(rd == rs - rt)
                err = 1'b0;
            else
                err = 1'b1;
        end
        else if(s == 3'b010) begin
            if(rd == rs + 1'b1)
                err = 1'b0;
            else
                err = 1'b1;
        end
        else if(s == 3'b011) begin
            if(rd == ~(rs | rt))
                err = 1'b0;
            else
                err = 1'b1;
        end
        else if(s == 3'b100) begin
            if(rd == ~(rs & rt))
                err = 1'b0;
            else
                err = 1'b1;
        end
        else if(s == 3'b101) begin
            if(rd == rs >> 2)
                err = 1'b0;
            else
                err = 1'b1;
        end
         else if(s == 3'b110) begin
            if(rd == rs << 1)
                err = 1'b0;
            else
                err = 1'b1;
        end
        else begin
            if(rd == rs * rt)
                err = 1'b0;
            else
                err = 1'b1;
        end
end
endtask


endmodule


       
        
        