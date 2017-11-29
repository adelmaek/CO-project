module ALU (A,B,op,overflow,Result); 

output  reg [31:0] Result;
output wire overflow;
input signed [31:0]  A,B;
input  wire [3:0] op;
wire [31:0] compareResult;
wire[31:0] Bnegated;
assign Bnegated = -B;
//input wire[5:0] shift ; 
/*
0000 A+B  
0001 A-B 
0010 SLL
0011 SRL 
0100 SRA
0101 Negate
0110 (A>b)1:((b<A)2:0)
0111 (A&B)
1000 (A|B)
*/
 
//Result
/*assign Result = (op==4'b0000)?(A+B):((op==4'b0001)?A-B:((op==4'b0010)?A<<shift:((op==4'b0011)?A>>shift:((op==4'b0100)?A>>>shift:((op==4'b0101)?-A:
((op==4'b0111)?A&B:((op==4'b1000)?A|B:((op==4'b0110)?compareResult:32'h00000000))))))));   
*/

always @*
begin
if(op==4'b0000)
begin Result = A+B; end
else if (op==4'b0001) begin  Result =A-B; end
else if (op==4'b0010) begin  Result =A<<1; end
else if (op ==4'b0011)begin  Result =A>>1; end
else if (op==4'b0100) begin  Result =A>>>1; end
else if (op==4'b0101) begin  Result =-A; end
else if (op==4'b0111) begin  Result =A&B; end
else if (op==4'b1000) begin  Result =A|B; end
else if (op==4'b0110) begin  Result =compareResult; end
else begin Result= 0; end
end


//OverFlow
assign overflow = ( (A[31]==B[31]) && (Result[31]==~A[31]) && op==4'b0000)?1'b1:
((  (A[31]==Bnegated[31])  &&  (Result[31]==~A[31]) && op==4'b0001)?1'b1:1'b0);


compareA_B comp (A,B,compareResult);



endmodule






module compareA_B (A,B,compareResult);  


input wire [31:0] A,B;
output wire [31:0]compareResult; 

assign compareResult = (A>B)?1:((A<B)?2:0);



endmodule
