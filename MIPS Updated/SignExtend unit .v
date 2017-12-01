module SignExtend(ImmediateField,ImmediateFieldSignextended);
input wire [15:0]ImmediateField; 
output reg[31:0] ImmediateFieldSignextended;
always@(ImmediateField)
begin
if(ImmediateField[15]==0) 
begin
ImmediateFieldSignextended = {16'd0,ImmediateField};
end
else if(ImmediateField[15]==1)
begin
ImmediateFieldSignextended = {16'd1,ImmediateField};
end
end
 

endmodule

