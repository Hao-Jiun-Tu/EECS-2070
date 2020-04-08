`timescale 1ns / 1ps
`define CYC 4

module Sliding_Window_Detector_t;
reg clk = 1'b1, rst_n = 1'b0;
reg in = 1'b0;
wire dec1, dec2;

Sliding_Window_Detector U0(clk, rst_n, in, dec1, dec2);

always #(`CYC / 2) clk = ~clk;

initial begin
  //Test 100010010011001
  @ (negedge clk) begin 
    in = 1'b1;
    rst_n = 1'b1;
  end;
  @ (posedge clk)
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk)

  //Test 10101101
  rst_n = 1'b0;  
  @ (negedge clk) begin 
    in = 1'b1;
    rst_n = 1'b1;
  end;
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b1;
  @ (posedge clk)
  @ (negedge clk) in = 1'b0;
  @ (posedge clk)
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  //111
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 

  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) 
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) 
  @ (negedge clk) $finish;
end

endmodule

