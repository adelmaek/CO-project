module ControlUnit ( OpCode , RegDst ,AluSrc , Branch , MemRead , MemWrite , RegWrite , Memtoreg ,AluOp  );
input [5:0] OpCode ; // comes from instruction last 6 instructions [31:26]
output reg RegDst , AluSrc , Branch , MemRead , MemWrite , RegWrite , Memtoreg ; 
output reg [1:0] AluOp ; 

always @(OpCode) 
begin 
	case (OpCode)
		6'b000000: //r-format
			begin
			RegDst = 1;
			AluSrc = 0;
			Branch = 0;
			MemRead = 0;
			MemWrite = 0;
			RegWrite = 1;
			Memtoreg = 0;
			AluOp = 2'b10;
			end
		6'b100011: //lw instruction
			begin
			RegDst = 0;
			AluSrc = 1;
			Branch = 0;
			MemRead = 1;
			MemWrite = 0;
			RegWrite = 1;
			Memtoreg = 1;
			AluOp = 2'b00;
			end
		6'b101011: // sw instruction
			begin
			//RegDst = 1; dn't care 
			AluSrc = 0;
			Branch = 0;
			MemRead = 0;
			MemWrite = 1;
			RegWrite = 0;
			//Memtoreg = 0; dn't care 
			AluOp = 2'b00;
			end
		6'b000100: //branch instruction
			begin
			//RegDst = 1; dn't care 
			AluSrc = 0;
			Branch = 1;
			MemRead = 0;
			MemWrite = 0;
			RegWrite = 0;
			//Memtoreg = 0; dn't care
			AluOp = 2'b01;
			end
	endcase
end 
endmodule 
module AluControl(FunctionCode , AluOp , OperationCode);
input[5:0] FunctionCode ; // comes from instruction first 6 instructions [5:0]
input [1:0] AluOp ; // coming from control unit 
output reg [3:0] OperationCode ; // input to alu 

always @ (FunctionCode or AluOp) 
begin 
	if ( AluOp == 2'b00) // we don't care abt the function code 
		OperationCode = 4'b0010; // this means lw or store //ben7tag ne3ml add fel alu 
	else if (AluOp == 2'b01)
		OperationCode = 4'b0110; // means branch // ben3ml substract 
	else if ( AluOp == 2'b10 && FunctionCode == 6'b100000)
		OperationCode = 4'b0010; // add 
	else if ( AluOp == 2'b10 && FunctionCode == 6'b100010)
		OperationCode = 4'b0110; //substract
	else if ( AluOp == 2'b10 && FunctionCode == 6'b100100)
		OperationCode = 4'b0000; //and operation
	else if ( AluOp == 2'b10 && FunctionCode == 6'b100101)
		OperationCode = 4'b0001; //or operation 
	else if ( AluOp == 2'b10 && FunctionCode == 6'b101010)
		OperationCode = 4'b0111; //set on less than 
end
endmodule 