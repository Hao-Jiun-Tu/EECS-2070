`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/16 23:43:13
// Design Name: 
// Module Name: dec_t
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


module dec_t;
reg [3:0]Din = 4'b0000;
wire [15:0]Dout;

dec U0(.Din(Din),
      .Dout(Dout) 
);
initial begin 
    repeat (2 ** 4) begin
        #1 Din = Din + 4'b0001;
     end
     #1 $finish;
     end 
endmodule
