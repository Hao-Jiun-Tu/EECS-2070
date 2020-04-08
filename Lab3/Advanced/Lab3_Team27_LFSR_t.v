`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 12:23:05
// Design Name: 
// Module Name: LFSR_t
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
`define CYC 4
module LFSR_t;
reg clk = 1'b1;
reg rst_n = 1'b0;
wire out;
/*wire [3:0] DFF_out;*/
LFSR U0(.clk(clk),
       .rst_n(rst_n),
       .out(out)/*,
       .DFF_out(DFF_out)*/
);

always #(`CYC / 2) clk = ~clk;

initial begin
	#(`CYC / 2);
	rst_n = 1'b1;
	@ (posedge clk)
    repeat (2 ** 8) begin
        #(`CYC / 2) ;
    end
    
    #(`CYC / 2);
	rst_n = 1'b0;
	@ (posedge clk)
    repeat (2 ** 2) begin
        #(`CYC / 2) ;
    end
     #(`CYC / 2);  
	rst_n = 1'b1;
	@ (posedge clk)
    repeat (2 ** 4) begin
        #(`CYC / 2) ;
    end
        $finish;
   
end


endmodule


	 

		

