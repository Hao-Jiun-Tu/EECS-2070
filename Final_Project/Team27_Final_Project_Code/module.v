module Clock_Divider(clk, clk_div);
    parameter n = 1;
    input clk;
    output clk_div;
   
    reg [n-1:0] num;
    wire [n-1:0] num_next;
   
    assign num_next = num + 1;
    assign clk_div = num[n-1];

    always @(posedge clk) begin
        num <= num_next;
    end
endmodule

module Pipe_clk_div(clk, clk_div);
    input clk;
    output clk_div;
   
    reg [19:0] num;
    wire [19:0] num_next;
   
    assign num_next = (num[19] && num[16] && num[17]) ? 20'd0 : num + 1;
    assign clk_div = (num[19] && num[16] && num[17]);

    always @(posedge clk) begin
        num <= num_next;
    end
endmodule



module debounce (pb_debounced, pb, clk);
  output pb_debounced;      // signal of a pushbutton after being debounced
  input  pb;                       // signal from a pushbutton
  input  clk;          
 
  reg [3:0] DFF;                       // use shift_reg to filter pushbutton bounce
  always @(posedge clk)
    begin
      DFF[3:1] <= DFF[2:0];
      DFF[0]   <= pb;
    end
  assign pb_debounced = &DFF;
endmodule

module onepulse (PB_debounced, clk, PB_one_pulse);
  input    PB_debounced;
  input    clk;
  output  PB_one_pulse;
  reg    PB_one_pulse;
  reg    PB_debounced_delay;
  always @(posedge clk) begin
      PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
      PB_debounced_delay <= PB_debounced;
  end
endmodule

module clk_expander(in, clk_q, out);
    input in, clk_q;
    output out;
    reg out = 1'b0;
    reg [3:0] count = 4'd0;

    always @(posedge clk_q) begin
        if (count == 4'd15) begin
            out <= 1'd0;
            count <= 4'd0;
        end
        else if (in == 1'b1) begin
            count <= count + 1;
            out <= 1'b1;
        end
        else if (out == 1'b1)
            count <= count + 1;
        else begin
            count <= 4'd0;
            out <= 1'b0;
        end
    end
endmodule