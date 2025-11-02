module multiplication #(parameter N=5)    ( input  [(N*11+10):0] a,input [(N*2+1):0]b,output  reg[(N*11+10):0]c ,input clk,input reset);
integer i,j;
reg  [(N*11+10):0]p;
reg [(N*2+1):0]q;
reg r,temp;
reg [$clog2(N):0]count;
reg carry,cout;
reg [10:0] comp;


always@(posedge clk)
begin
r=0;
if(reset)
begin

  count=0;
  p=a;
  q=b;
  c=0;
  temp=0;
  r=1;

end

else 
begin

 p= {p[(N*11-1):(N*11-11)],p[(N*11-12):0],p[(N*11+10):(N*11)]};
if(count!=(N+1))
begin

r=1;
end
else
r=0;

end

end
always@(posedge clk)

begin
if(r==1)
begin

if({q[(2*count)+1],q[2*count]}==2'b01)
begin

for(i=0;i<(11*N+11);i=i+11)
begin
carry=0;
for(j=0;j<11;j=j+1)
begin
{cout,c[i+j]}=c[i+j]+p[i+j]+carry;

carry=cout;
end

end
end
else
if({q[(2*count)+1],q[2*count]}==2'b11)
begin

for(i=0;i<(11*N+11);i=i+11)
begin:complement


carry=0;
for(j=0;j<11;j=j+1)
begin

if(p[i+j]==1||temp)
begin
if(temp==0)
begin
comp[j]=p[i+j];
temp=1;

end
else
begin
comp[j]=~p[i+j];
end


end 
else
begin
comp[j]=p[i+j];


end



end
temp=0;

for(j=0;j<11;j=j+1)
begin

{cout,c[i+j]}=c[i+j]+comp[j]+carry;
carry=cout;
end

end

end
count=count+1;

end

end

endmodule
