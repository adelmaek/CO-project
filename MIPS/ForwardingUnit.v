module forwarding(
input EXMEMRegWrite,			//
input [4:0] EXMEMRegisterRd,   		//
input [4:0]IDEXRegisterRs,		//
input [4:0]IDEXRegisterRt,		//
input MEMWBRegWrite,			//
input [4:0]MEMWBRegisterRd,	//
output reg[1:0]ForwardA,
output reg[1:0]ForwardB
);
always @*
begin
if (EXMEMRegWrite && (EXMEMRegisterRd!=0) && ( EXMEMRegisterRd == IDEXRegisterRs))		//Iwant to write in EXMEM, and I want to use this value in the next instr
ForwardA<=2'b10;										// as an output to the ALU Rd el fatet== Rs delw2ty
if (EXMEMRegWrite && (EXMEMRegisterRd != 0) && ( EXMEMRegisterRd == IDEXRegisterRt)) 		//same but Rt
ForwardB <=2'b10;

if (MEMWBRegWrite && (MEMWBRegisterRd != 0) 		//i want to write in the thrd instr.	
&& ~(EXMEMRegWrite && (EXMEMRegisterRd != 0) 		//either i dont wanna write in the middle instr, or i want to write in 0
&& (EXMEMRegisterRd != IDEXRegisterRs)) 		//bat2aked en el inst el fl nos maghyrsh Rd
&& (MEMWBRegisterRd == IDEXRegisterRs)) 		///Rs == Rd bta3et el abl el fatet
ForwardA <= 2'b01;

if (MEMWBRegWrite &&(MEMWBRegisterRd != 0)
&& ~(EXMEMRegWrite && (EXMEMRegisterRd != 0)
&& (EXMEMRegisterRd != IDEXRegisterRt))		//same but Rt
&& (MEMWBRegisterRd ==IDEXRegisterRt)) 
ForwardB <=2'b01;
end

endmodule


