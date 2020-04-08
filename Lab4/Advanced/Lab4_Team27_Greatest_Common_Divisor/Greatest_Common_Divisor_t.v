`timescale 1ns / 1ps
`define CYC 4

module Greatest_Common_Divisor_t;
reg clk = 1'b1, rst_n = 1'b1;
reg Begin = 1'b1;
reg [8-1:0] a;
reg [8-1:0] b;
wire Complete;
wire [8-1:0] gcd;

Greatest_Common_Divisor U0(.clk(clk), 
                        .rst_n(rst_n), 
                        .Begin(Begin), 
                        .a(a), 
                        .b(b), 
                        .Complete(Complete), 
                        .gcd(gcd)
);

always #(`CYC / 2) clk = ~clk;

initial begin
    @ (negedge clk) rst_n = 1'b0;
    @ (posedge clk) 

    @ (negedge clk) begin 
    rst_n = 1'b1;
    Begin = 1'b0;
    a = 8'd78;
    b = 8'd24; 
    end;
    @ (posedge clk)      
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
    
    
    
    
    @ (negedge clk) begin 
    Begin = 1'b0;
    a = 8'd22;
    b = 8'd77; 
    end;
    @ (posedge clk)
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
    
    
    @ (negedge clk) begin 
    Begin = 1'b0;
    a = 8'd89;
    b = 8'd23; 
    end;
    @ (posedge clk)
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
        
    @ (negedge clk) begin 
    Begin = 1'b0;
    a = 8'd255;
    b = 8'd25; 
    end;
    @ (posedge clk)
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
    
    @ (negedge clk) begin 
    Begin = 1'b0;
    a = 8'd236;
    b = 8'd136; 
    end;
    @ (posedge clk)
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
    
    @ (negedge clk) begin 
    Begin = 1'b0;
    a = 8'd100;
    b = 8'd120; 
    end;
    @ (posedge clk)
    @ (negedge clk) Begin = 1'b1;
    @ (posedge clk)
    #(`CYC*20);
    
    @ (negedge clk) $finish;
end
endmodule
