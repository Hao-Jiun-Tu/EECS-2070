`timescale 1ns/1ps

module RippleCarryAdder_t;
// global clock signal: change input at engedge clk
reg CLK;

// inputs to testing module
reg [4-1:0] A, B;
reg Cin;

// outputs from testing module
wire [4-1:0] Sum;
wire Cout;

// declare testing module
RippleCarryAdder testing_instance (
  .A (A),
  .B (B),
  .Cin (Cin),
  .Sum (Sum),
  .Cout (Cout)
);

// simulate a clock with 5ns on-time and 5ns off-time 
always #5 CLK = ~CLK;
initial CLK = 1'b1;

// main testing
initial begin
  {A, B, Cin} = 9'd0;
	 
  repeat (2 ** 9) begin
	@ (posedge CLK)
		Test;
    @ (negedge CLK)
		{A, B, Cin} = {A, B, Cin} + 1'b1;
  end

  $finish;
end

task Test;
begin
	if({Cout, Sum} !== (A + B + Cin))begin
		$display("[ERROR]");
		$write("A:%d",A);
		$write("B:%d",B);
		$write("Cin:%d",Cin);
		$write("Cout:%d",Cout);
		$write("Sum:%d",Sum);
		$display;
	end
end
endtask

endmodule
