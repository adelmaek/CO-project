module clock(clk);
output reg clk;
initial 
begin
clk<=1'b0; 
end
always
begin
#10
clk<=~clk; 
end
initial
begin
#1000
 $stop;
end
endmodule
