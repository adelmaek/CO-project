module Fetching (BranchAdress,MuxBranchControl,clk,IFIDpcPlusFour,IFIDinstruction);
input wire [31:0] BranchAdress;
input wire MuxBranchControl;
input wire clk; 
output reg [31:0] IFIDpcPlusFour;
output reg [31:0] IFIDinstruction;  
wire[31:0] pcPlusFour;
reg [31:0]PC;    
reg [31:0] InstructionMemory[31:0];
wire[31:0] muxPc;  
wire instruction;


assign pcPlusFour=PC+4;
assign instruction=InstructionMemory[PC>>2];
initial
begin
InstructionMemory[0]<=0;
InstructionMemory[1]<=1; 
InstructionMemory[10]<=10;
#50
PC<=0;
end

always@(posedge clk)
begin
PC<=muxPc;

end


always@(posedge clk)
begin
IFIDpcPlusFour<=pcPlusFour;
IFIDinstruction<=instruction;
end


Mux mux1 (pcPlusFour,BranchAdress,MuxBranchControl,muxPc);

endmodule





module FetchingTB();
reg [31:0] BranchAdress;
reg MuxBranchControl;
wire [31:0] IFIDpcPlusFour;
wire [31:0] IFIDinstruction;
wire clk;
initial 
begin 
BranchAdress=0;
MuxBranchControl=1;
#25
MuxBranchControl=1;
BranchAdress=10;
end
Fetching F(BranchAdress,MuxBranchControl,clk,IFIDpcPlusFour,IFIDinstruction);
clock c (clk);
endmodule
