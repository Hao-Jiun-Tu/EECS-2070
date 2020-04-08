`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/30 17:42:57
// Design Name: 
// Module Name: Lab2_TeamX_Multiplier_t
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


module Lab2_TeamX_Multiplier_t;
reg [3:0] a, b;
wire  [7:0] p;
reg CLK, err;

Multiplier V0(
    .a(a),
    .b(b),
    .p(p)
);

always #1 CLK = ~CLK;
initial CLK = 1'b1;

initial begin
    {a, b} = 8'b0;
    
    repeat (2 ** 8) begin
	@ (posedge CLK)
		 Test;
    @ (negedge CLK)
		 {a, b} =  {a, b} + 1'b1;
  end
     $finish;
end


task Test;
begin
    if( p == a * b  )
        err = 0;
    else 
        err = 1;
end
endtask

endmodule
