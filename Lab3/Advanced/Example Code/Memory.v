`timescale 1ns / 1ps

module Memory (clk, ren, wen, addr, din, dout);
input clk;
input ren, wen;
input [6-1:0] addr;
input [8-1:0] din;
output [8-1:0] dout;

reg [8-1:0] MEM [64-1:0];
reg [8-1:0] dout;

always @(posedge clk) begin
    if(ren)
        dout <= MEM[addr];
    else
        dout <= 8'b00000000;
end

always @(*) begin
    if(wen && !ren)
        MEM[addr] = din;
    else
        MEM[addr] = MEM[addr];
end
endmodule