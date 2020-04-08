`timescale 1ns / 1ps
module Binary_To_GrayCode_test;
reg [3:0] Din = 4'd0;
wire [3:0] Dout;

Binary_To_GrayCode U0(.Din(Din),
                 .Dout(Dout)
);

initial begin
    repeat(2 ** 4) begin
        #1 Din = Din + 4'd1;
    end
    #1 $finish;
end
endmodule