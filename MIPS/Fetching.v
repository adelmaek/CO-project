module Fetching (BranchAdress,PcPlusFour,muxCtrl,clk,instruction,IFIDpcplusfour,IFIDinstruction,ImmediateFieldSignextended);
output reg [31:0]IFIDpcplusfour;
output reg [31:0]IFIDinstruction;
output reg [31:0] ImmediateFieldSignextended;
input wire [31:0]BranchAdress; 
input clk;
input muxCtrl; 
output reg[31:0] PcPlusFour;
output wire [31:0]instruction;
reg [31:0]PC; 
wire [31:0] muxPc;
reg [31:0] instructionMem [31:0];
assign instruction = instructionMem[PC];

initial
begin
instructionMem[0]<=32'd0; 
instructionMem[0]<=32'd1;
PC <=0;
PcPlusFour<=PC;
end


always@(posedge clk)
begin 
PC<=muxPc;
PcPlusFour<=PC+4;
end


Mux mux1 (PcPlusFour,BranchAdress,muxCtrl,muxPc);
clock c1 (clk);

endmodule

