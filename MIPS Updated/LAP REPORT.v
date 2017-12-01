module finiteStateMachineLab (rst_n,jmp,go,y1,cstate);
input rst_n;
input go;
input jmp;
output reg y1;
output reg [3:0]cstate;
reg [3:0]nstate;
reg clk;
parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=5'b0100,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=8,s9=9;
always@(posedge clk)
begin
cstate<=nstate;
end
always@(rst_n)
begin
if(!rst_n)
begin 
cstate<=s0;
end
end

always@(rst_n,go,jmp,cstate) 
begin
case (cstate)
s0:
begin
if(!go)nstate<=s0;
else if (!rst_n)nstate<=s0;
else if (go && jmp)nstate<=s3;
else if(go && !jmp)nstate<=s1;
y1<=0;
end
s1:
begin
if(!jmp)nstate<=s2;
else if(jmp)nstate<=s3;
y1<=0;
end
s2:
begin 
nstate<=s3;
y1<=0;
end
s3:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s4;
y1<=1;
end
s4:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s5;
y1<=0;
end

s5:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s6;
y1<=0;
end
s6:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s7;
y1<=0;

end
s7:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s8;
y1<=0;

end
s8:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s9;
y1<=0;

end
s9:
begin
if(jmp)nstate<=s3;
else if(!jmp)nstate<=s0;
y1<=1;
end
endcase
end


endmodule



