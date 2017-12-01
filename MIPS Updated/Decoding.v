module Decoding (IFIDpcplusfour,IFIDinstruction,clk,ImmediateFieldSignextended,writeData,MemWBwritereg,WriteRegEnable,AluSrc,
Reg_Dst,AluOp,WriteMemoryEnable,ReadMemoryEnable,writebackRegCtrl,BranchAdress,IDIExreadData1,IDIExreadData2,opCode,IDExRs,IDExRt,IDExRd,
IDExImmediateFieldSignextended,IDExWriteRegEnable,IDExAluSrc,IDExReg_dst,IDExAluOp,IDExWriteMemoryEnable,IDExReadMemoryEnable,IDExwritebackRegCtrl);
input wire [31:0]IFIDpcplusfour;
input wire [31:0]IFIDinstruction;
input wire clk;
input wire [31:0] ImmediateFieldSignextended;
input wire [31:0] writeData;
input wire[4:0] MemWBwritereg;
input wire WriteRegEnable;//from control unit
input wire AluSrc;
input wire Reg_Dst;
input wire [3:0]AluOp;
input wire WriteMemoryEnable;//from control unit
input wire ReadMemoryEnable;
input wire writebackRegCtrl;


output reg[31:0] BranchAdress;  
output reg[31:0] IDIExreadData1;
output reg[31:0] IDIExreadData2;
output wire [5:0] opCode;
output reg[4:0]IDExRs;
output reg[4:0]IDExRt;
output reg[4:0]IDExRd;
output reg[31:0]IDExImmediateFieldSignextended;
output reg IDExWriteRegEnable;
output reg IDExAluSrc;
output reg IDExReg_dst;
output reg[3:0] IDExAluOp;
output reg IDExWriteMemoryEnable;
output reg IDExReadMemoryEnable;
output reg IDExwritebackRegCtrl;
//lessa na2es el IDIEcontrol output registers
wire[31:0] readData1; 
wire [31:0] readData2; 
wire [4:0]readReg1;
wire [4:0] readReg2;
wire clk;
reg[31:0] registerFile[31:0];
reg [31:0] ImmediateFieldSignextendedShifted;


assign readData1 = registerFile[readReg1];
assign readData2 = registerFile[readReg2];
assign readReg1=IFIDinstruction[25:21];
assign readReg2=IFIDinstruction[20:16];
assign opCode = IFIDinstruction[31:26];
initial
begin
registerFile[0]<=0;
registerFile[1]<=1;
end
always@*
begin
ImmediateFieldSignextendedShifted <=ImmediateFieldSignextended<<2;
BranchAdress<=IFIDpcplusfour+ImmediateFieldSignextendedShifted;
end

always@*//mesh el mfrod m3 el clock ?
begin
if(WriteRegEnable)
begin
registerFile[MemWBwritereg] <= writeData;
end
end

always@(posedge clk)
begin
IDIExreadData2<=readData2;
IDIExreadData1<=readData1; 
IDExRs<=readReg1;
IDExRt<=readReg2;
IDExRd<=IFIDinstruction[15:11];
IDExWriteRegEnable<=WriteRegEnable;
IDExAluSrc<=AluSrc;
IDExReg_dst<=Reg_Dst;
IDExAluOp<=AluOp;
IDExWriteMemoryEnable<=WriteMemoryEnable;
IDExReadMemoryEnable<=ReadMemoryEnable;
IDExwritebackRegCtrl<=writebackRegCtrl;
end

 
SignExtend s1(IFIDinstruction[15:0],ImmediateFieldSignextended);

endmodule









module DecodingTB ();
reg [31:0]IFIDpcplusfour;
reg[31:0]IFIDinstruction;
reg[31:0] ImmediateFieldSignextended;
reg[31:0] writeData;
reg[4:0] MemWBwritereg;
reg WriteRegEnable;//from control unit
reg AluSrc;
reg Reg_Dst;
reg [3:0]AluOp;
reg WriteMemoryEnable;//from control unit
reg ReadMemoryEnable;
reg writebackRegCtrl;
reg clk;

wire [31:0] BranchAdress;  
wire [31:0] IDIExreadData1;
wire[31:0] IDIExreadData2;
wire [5:0] opCode;
wire[4:0]IDExRs;
wire[4:0]IDExRt;
wire[4:0]IDExRd;
wire IDExWriteRegEnable;
wire IDExAluSrc;
wire IDExReg_dst;
wire[3:0] IDExAluOp;
wire IDExWriteMemoryEnable;
wire IDExReadMemoryEnable;
wire IDExwritebackRegCtrl;

initial
begin
$monitor("BranchAdress=%d,IDIExreadData1=%d,IDIExreadData2=%d,opCode=%d,IDExRs=%d",BranchAdress,IDIExreadData1,IDIExreadData2,opCode,IDExRs)
end


Decoding x(IFIDpcplusfour,IFIDinstruction,clk,ImmediateFieldSignextended,writeData,MemWBwritereg,WriteRegEnable,AluSrc,
Reg_Dst,AluOp,WriteMemoryEnable,ReadMemoryEnable,writebackRegCtrl,BranchAdress,IDIExreadData1,IDIExreadData2,opCode,IDExRs,IDExRt,IDExRd,
IDExImmediateFieldSignextended,IDExWriteRegEnable,IDExAluSrc,IDExReg_dst,IDExAluOp,IDExWriteMemoryEnable,IDExReadMemoryEnable,IDExwritebackRegCtrl);


clock c (clk);

endmodule
