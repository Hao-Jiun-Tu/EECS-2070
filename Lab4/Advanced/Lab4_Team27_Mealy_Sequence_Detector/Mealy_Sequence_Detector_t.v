`timescale 1ns / 1ps
`define CYC 4

module Mealy_Sequence_Detector_t;
reg clk = 1'b1, rst_n = 1'b1;
reg in = 1'b0;
wire dec;

Mealy_Sequence_Detector U0(.clk(clk), 
                        .rst_n(rst_n), 
                        .in(in), 
                        .dec(dec)
);

always #(`CYC / 2) clk = ~clk;

initial begin
  @ (negedge clk) rst_n = 1'b0;
  @ (posedge clk) 
  
  //Test 1101
  @ (negedge clk) begin 
    in = 1'b1;
    rst_n = 1'b1;
  end;
  @ (posedge clk) // S0 -> S1
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S1 -> S2
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S2 -> S3
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S3 -> S0
  
   //Test 0010
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S0 -> S4
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S4 -> S5
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S5 -> S6
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S6 -> S0
  
   //Test 1001
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S0 -> S1
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) // S1 -> S7
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S7 -> S8
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S8 -> S0
  
   //Test 1101
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S0 -> S1
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S1 -> S2
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S2 -> S3
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S3 -> S0
  
  //Test 1110
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S0 -> S1
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S1 -> S2
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S2 -> S9
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S9 -> S0
  
   //Test 1101
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S0 -> S1
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) // S1 -> S2
  @ (negedge clk) in = 1'b0;
  @ (posedge clk) //  S2 -> S3
  @ (negedge clk) in = 1'b1;
  @ (posedge clk) //  S3 -> S0
  
  @ (negedge clk) $finish;
end




endmodule
