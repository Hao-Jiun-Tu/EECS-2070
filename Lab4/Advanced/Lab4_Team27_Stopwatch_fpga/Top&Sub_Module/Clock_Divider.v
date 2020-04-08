`timescale 1ns / 1ps
module Clock_Divider #(parameter n = 24) (clk, dclk, sctl_clk);
input clk;
output dclk;
output [1:0] sctl_clk;
reg [n-1:0] num;
wire [n-1:0] next_num;
always @(posedge clk) begin
    if(num[n-1] == 1'b1 && num[n-4] == 1'b1 && num[n-5] == 1'b1)
        num <= 24'd0;
    else
        num <= next_num;
end
assign next_num = num + 1'b1;
assign dclk = num[n-1];
assign sctl_clk = {num[15:14]};

endmodule
