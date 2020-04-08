module Random #(parameter n = 10101101)(
    input clk,
    input rst,
    output [7:0] num
    );
    reg [7:0] num, next_num;
    wire out;
    assign out = num[3] ^ num[7];
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            num <= n;
        end else begin
            num[7:1] <= num[6:0];
            num[0] <= out;
        end
    end
endmodule
