`timescale 1ns / 1ps

module debounce (pb_debounced, pb, clk);
output pb_debounced; // signal of a pushbutton after being debounced
input pb; // signal from a pushbutton
input clk;

reg [3:0] DFF; // use shift_reg to filter pushbutton bounce
always @(posedge clk) begin
    DFF[3:1] <= DFF[2:0];
    DFF[0] <= pb;
end
assign pb_debounced = ((DFF == 4'b1111) ? 1'b0 : 1'b1);

endmodule
