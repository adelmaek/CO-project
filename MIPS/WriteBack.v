module WriteBack(MemWbAluOutput,MemWbMemoryReadData,ExMemDestination_Rt_RdOutput,MemWbWriteRegEnable,MemWbwritebackRegCtrl,writeData,RegFileWriteReg,
WriteRegEnable);
input wire[31:0] MemWbAluOutput;
input wire[31:0] MemWbMemoryReadData;
input wire [4:0] ExMemDestination_Rt_RdOutput;
input wire MemWbWriteRegEnable;
input wire MemWbwritebackRegCtrl;


output wire [31:0] writeData;
output wire[4:0] RegFileWriteReg;
output wire WriteRegEnable;

assign RegFileWriteReg = ExMemDestination_Rt_RdOutput;
assign WriteRegEnable = MemWbWriteRegEnable;



Mux writeBackMux (MemWbAluOutput,MemWbMemoryReadData,MemWbwritebackRegCtrl,writeData);

endmodule
