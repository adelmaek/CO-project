module Mux(data1,data2,muxCtrl,out);
input wire[31:0] data1;
input wire[31:0] data2;
input muxCtrl;
output wire [31:0]out;

assign out = muxCtrl?data2:data1;
endmodule


 