`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/19 14:28:17
// Design Name: 
// Module Name: RAC_t
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
module RCA_t;
reg [3:0]A = 4'b0000;
reg [3:0]B = 4'b0000;
reg Cin = 1'b0;
wire [3:0]Sum;
wire Cout;
RippleCarryAdder U(.A(A),
     .B(B),
     .Cin(Cin),
     .Sum(Sum),
     .Cout(Cout)
);

initial begin 
    repeat (2 ** 9) begin
        #0.1 {A, B, Cin} = {A, B, Cin} + 9'b000000001;
    end
    #1 $finish;
end 
endmodule