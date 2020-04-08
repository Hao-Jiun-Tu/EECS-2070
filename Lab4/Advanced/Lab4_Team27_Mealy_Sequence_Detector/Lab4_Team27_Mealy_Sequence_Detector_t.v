`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/02 15:30:55
// Design Name: 
// Module Name: Lab4_Team27_Mealy_Sequence_Detector_t
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


module test;
reg [3:0] i;
reg clk = 1'b0, rst_n = 1'b0;
reg in;
wire dec;

Mealy_Sequence_Detector U0(
    .clk(clk),
    .rst_n(rst_n),
    .in(in),
    .dec(dec)
);

always #1 clk = ~clk;

initial begin
    i = 4'b0;
    #2 rst_n = 1'b1;
    repeat(16) begin
        in = i[3];
        #2 in = i[2];
        #2 in = i[1];
        #2 in = i[0];
        #2 i = i + 1'b1;
    end 
    $finish;
end

endmodule
