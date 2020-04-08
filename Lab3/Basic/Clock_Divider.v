`timescale 1ns / 1ps

module Clock_Divider(sel, rst_n, clk, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
input [1:0] sel;
input rst_n, clk;
output clk1_2, clk1_4, clk1_8, clk1_3, dclk;
reg In ;
reg [1:0] In_1;
reg [2:0] In_2;
reg In_3;
reg count = 1'b1;
reg dclk;
always @(posedge clk) 
begin
    if(~rst_n) 
        In <= 1'b0;
    else
        In <= In + 1'b1;    
end
assign clk1_2 = In;

always @(posedge clk) 
begin
    if(~rst_n) 
        In_1 <= 2'b01;
    else
        In_1 <= In_1 + 2'b01;    
end
assign clk1_4 = In_1[1];

always @(posedge clk) 
begin
    if(~rst_n) 
        In_2 <= 3'b011;
    else
        In_2 <= In_2 + 3'b001;    
end
assign clk1_8 = In_2[2]; 

always @(posedge clk) 
begin
    if(~rst_n)
    begin 
        In_3 <= 1'b0;
        count <= 1'b1;
    end
    else if(In_3 == 1'b1)
    begin 
        In_3 <= 1'b0;
        count <= 1'b0;
    end
    else if(In_3 == 1'b0 && count == 1'b0)
    begin
        In_3 <= In_3;
        count <= 1'b1;
    end
    else if(In_3 == 1'b0 && count == 1'b1)
    begin
        In_3 <= 1'b1;
        count <= 1'b0;
    end
end
assign clk1_3 = In_3;

always @(*)
    case(sel)
    2'b00: dclk = In_3; //clk1_3
    2'b01: dclk = In;//clk1_2
    2'b10: dclk = In_1[1];//clk1_4
    2'b11: dclk = In_2[2];//clk1_8
    default: dclk = 0;
    endcase
endmodule