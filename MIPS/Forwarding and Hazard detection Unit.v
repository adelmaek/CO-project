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
ForwardA<=2'b10;								// as an output to the ALU Rd el fatet== Rs delw2ty
else if (MEMWBRegWrite && (MEMWBRegisterRd != 0) 		//i want to write in the thrd instr.	
&& ~(EXMEMRegWrite && (EXMEMRegisterRd != 0) 		//either i dont wanna write in the middle instr, or i want to write in 0
&& (EXMEMRegisterRd != IDEXRegisterRs)) 		//bat2aked en el inst el fl nos maghyrsh Rd
&& (MEMWBRegisterRd == IDEXRegisterRs)) 		///Rs == Rd bta3et el abl el fatet
ForwardA <= 2'b01;
else 
ForwardA=2'b00;
								
if (EXMEMRegWrite && (EXMEMRegisterRd != 0) && ( EXMEMRegisterRd == IDEXRegisterRt)) 		//same case but Rt
ForwardB <=2'b10;

else if (MEMWBRegWrite &&(MEMWBRegisterRd != 0)
&& ~(EXMEMRegWrite && (EXMEMRegisterRd != 0)
&& (EXMEMRegisterRd != IDEXRegisterRt))		//same but Rt
&& (MEMWBRegisterRd ==IDEXRegisterRt)) 
ForwardB <=2'b01;
else 
ForwardB<=2'b00;


end

endmodule



module HazardDetection(		//to detect if an instr is using a value still being loaded from memory.
input IDEXMemRead,		//will insert a stall -nop-
input [4:0] IDEXRegisterRt,	//and will make the pc stay with the same address
input [4:0] IFIDRegisterRs,			//will make the values in IFID reg get the same values again.
input [4:0] IFIDRegisterRt,
output reg IFIDWrite,
output reg PCWrite,
output reg stall
);

always@*
begin

if (IDEXMemRead &&    	//if it is a load instruction
((IDEXRegisterRt == IFIDRegisterRs) ||(IDEXRegisterRt == IFIDRegisterRt)))		//checks if I am using the value that I just loaded
begin
stall<=1;//control lines (EX, MEM, and WB)in the ID/EX reg being set to zero only RegWrite and MemWrite
PCWrite<=0;	//control signal sent to PC reg to tell it not to update its values.
IFIDWrite<=0; 	//control signal sent to IFID reg to tell it not to update its values.
end
else
begin
stall<=0;
PCWrite<=1;
IFIDWrite<=1;
end

end

endmodule


