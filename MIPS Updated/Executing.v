module execution(IDIExreadData1,IDIExreadData2,ExMemAluOutput,WriteBackValue,IDExRs,IDExRt,IDExRd,IDExImmediateFieldSignextended,IDEXWriteRegEnable,
AluOp,Reg_dst,AluSrc,ForwardingMux1Ctrl,ForwardingMux2Ctrl,IDExWriteMemoryEnable,IDExReadMemoryEnable,IDExwritebackRegCtrl,ExMemAluout,ExMemReadData2,
ExMemDestination_Rt_RdOutput,ExMemWriteRegEnable,ExMemWriteMemoryEnable,ExMemReadMemoryEnable,ExMemwritebackRegCtrl); 
input wire[31:0]IDIExreadData1;
input wire[31:0]IDIExreadData2;
input wire[31:0]ExMemAluOutput;//from memory phase for forwarding
input wire[31:0]WriteBackValue;
input wire [4:0] IDExRs;
input wire [4:0] IDExRt;
input wire [4:0] IDExRd;
input wire [31:0] IDExImmediateFieldSignextended; 
input wire IDEXWriteRegEnable;
input wire [3:0] AluOp;
input wire Reg_dst;
input wire AluSrc;
input wire ForwardingMux1Ctrl;//from forwarding Unit
input wire ForwardingMux2Ctrl;
input wire IDExWriteMemoryEnable;
input wire IDExReadMemoryEnable;
input wire IDExwritebackRegCtrl;


output reg[31:0]ExMemAluout;//output of alu to pipeline
output reg[31:0]ExMemReadData2;//Rt for memory operations(lw,Sw)
output reg[4:0]ExMemDestination_Rt_RdOutput;
output reg ExMemWriteRegEnable;
output reg ExMemWriteMemoryEnable;
output reg ExMemReadMemoryEnable;
output reg ExMemwritebackRegCtrl;
wire [4:0] Destination_Rt_RdOutput; 
wire [31:0] forwardingMux1Output;
wire [31:0] forwardingMux2Output;
wire [31:0] AluSeconedInputMuxOutput;
wire[31:0] AluResult;
wire overflow;
wire clk;

always@(posedge clk)
begin
ExMemAluout<=AluResult;
ExMemReadData2<=forwardingMux2Output;
ExMemDestination_Rt_RdOutput<=Destination_Rt_RdOutput;
ExMemWriteRegEnable<=IDEXWriteRegEnable;
ExMemReadMemoryEnable<=IDExReadMemoryEnable;
ExMemwritebackRegCtrl<=IDExwritebackRegCtrl;
end 

ALU alu (forwardingMux1Output,AluSeconedInputMuxOutput,AluOp,overflow,AluResult);
mux3x2 forwardingMux1 (IDIExreadData1,ExMemAluOutput,WriteBackValue,ForwardingMux1Ctrl,forwardingMux1Output);
mux3x2 forwardingMux2 (IDIExreadData2,ExMemAluOutput,WriteBackValue,ForwardingMux2Ctrl,forwardingMux2Output);
Mux Destination_Rt_Rd (IDExRt,IDExRd,AluSrc,Destination_Rt_RdOutput);
Mux AluSeconedInputMux(forwardingMux2Output,IDExImmediateFieldSignextended,Reg_dst,AluSeconedInputMuxOutput);
clock c (clk);
endmodule
