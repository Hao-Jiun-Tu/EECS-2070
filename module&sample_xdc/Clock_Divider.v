`timescale 1ns / 1ps
module Clock_Divider #(parameter n = 23) (clk, dclk, sctl_clk);
input clk;
output dclk;
output [1:0] sctl_clk;
reg [n-1:0] num;
wire [n-1:0] next_num;
always @(posedge clk) begin
        num <= next_num;
end
assign next_num = num + 1'b1;
assign dclk = num[n-1];
assign sctl_clk = {num[15:14]};

endmodule
