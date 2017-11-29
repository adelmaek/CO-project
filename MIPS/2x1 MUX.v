module Mux(data1,data2,muxCtrl,out);
input wire[31:0] data1;
input wire[31:0] data2;
input muxCtrl;
output reg [31:0]out;

always@(data1,data2,muxCtrl) 
begin 
if(muxCtrl==1'b0)
	out =data1;
else if (muxCtrl==1'b1)
	out=data2; 
else if(muxCtrl==1'bz)
	out = 32'bz;
else 
	out= 32'bx;
end
endmodule


