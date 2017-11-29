module memory (ExMemAluOutput,ExMemReadData2,WriteBackDest,writeMemoryEnable,readMemoryEnable,ExMemwriteRegEnable,ExMemwritebackRegCtrl,MemWbAluOutput,
MemWbMemoryReadData,MemWbWriteBackDest,MemWbwriteRegEnable,ExMemwritebackRegCtrl,MemWbAluOutput,MemWbMemoryReadData,MemWbWriteBackDest,MemWbwriteRegEnable,
MemWbwritebackRegCtrl,);
input wire[31:0]ExMemAluOutput;
input wire[31:0]ExMemReadData2;//output of seconed forwarfing mux for -->input data to memory
input wire[4:0]WriteBackDest;
input wire writeMemoryEnable;
input wire readMemoryEnable;
input wire ExMemwriteRegEnable;
input wire ExMemwritebackRegCtrl; 

//lessa el controls
output reg [31:0] MemWbAluOutput;
output reg [31:0] MemWbMemoryReadData;
output reg [4:0] MemWbWriteBackDest;
output reg MemWbwriteRegEnable;
output reg MemWbwritebackRegCtrl;
reg [31:0] DataMemory [31:0];
wire [31:0] MemoryReadData;



assign MemoryReadData = DataMemory[ExMemAluOutput>>2];

always@*
begin
if(readMemoryEnable)
begin
MemWbMemoryReadData<=MemoryReadData;
end
MemWbAluOutput<=ExMemAluOutput;
MemWbWriteBackDest<=WriteBackDest;
MemWbwriteRegEnable<=ExMemwriteRegEnable;
if(writeMemoryEnable)
begin
DataMemory[ExMemAluOutput>>2]<=ExMemReadData2;
end
MemWbwritebackRegCtrl<=ExMemwritebackRegCtrl;
end

endmodule
