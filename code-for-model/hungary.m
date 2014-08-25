%匈牙利算法
function [y,fval,flag]=Hungary(C)%y返回的是最优值的行列号
%**************************************************************************
% 匈牙利方法解决指派问题
% C：效益矩阵
% M：指派矩阵
% fval：最优值
%  
% 编译环境：matlab 6.5   最后修改时间：     编程： 徐射雕
% 
% 用法：
%   [y,fval]=Hungary(A)
%   y=Hungary(A)
% 参数说明:
%   y:得到的最优指派矩阵
%   fval:得到的最优值
%   A:效益矩阵
% 范例 
% >> C=[2 15 13 4;10 4 14 15;9 14 16 13;7 8 11 9]
% >> [y,fval]=Hungary(C)

% M =

%     0     0     0     1
%     0     1     0     0
%     1     0     0     0
%     0     0     1     0

% y =
%    28
% >> 
%***************************************************************************
[m,n]=size(C);
tempC=C;
%%%以下两个循环使每行每列都出现零元素
for i=1:m
tempC(i,:)=tempC(i,:)-min(tempC(i,:));
end
for i=1:n
tempC(:,i)=tempC(:,i)-min(tempC(:,i));
end       
tempC=TryAssign(tempC); %对每行每列都产生了零的矩阵进行试派              
OneNumber=0;%每行独立零的个数
for i=1:m                        
for j=1:n
if tempC(i,j)==inf
OneNumber=OneNumber+1;
break;
end
end
end
while OneNumber<m%如果独立的零可个数小于行数
Row=zeros(m,1);     
Col=ones(1,n);      
Line=[];
for i=1:m
if IsInMatrix(inf,tempC(i,:))==0
Line=[Line,i];
Row(i)=1;
end
end
for i=Line
Cur=i;
while Cur~=0
[Cur,Row,Col]=ZeroCover(tempC,Row,Col,Cur);%用最少的直线覆盖所得零
end
end
temp=inf;
for i=1:m     
for j=1:n
if Row(i)==1&Col(j)==1&tempC(i,j)<temp
temp=tempC(i,j);
end
end
end
for i=1:m
for j=1:n
if tempC(i,j)==inf|tempC(i,j)==-inf
tempC(i,j)=0;
end
end
end
for i=1:m   
if Row(i)==1
tempC(i,:)=tempC(i,:)-temp;
end
end
for j=1:n   
if Col(j)==0
tempC(:,j)=tempC(:,j)+temp;
end
end
tempC=TryAssign(tempC);%进行试派
OneNumber=0;%独立的零的个数
for i=1:m                        
for j=1:n
if tempC(i,j)==inf
OneNumber=OneNumber+1;
break;
end
end
end
end%while
AssignMatrix=zeros(m,n); %指派矩阵
for i=1:m
for j=1:n
if tempC(i,j)==inf
AssignMatrix(i,j)=1;
end
end
end
y=AssignMatrix;
temp=C.*AssignMatrix;
fval=sum(temp(:));

%% 判断矩阵A中是否含有元素a
%% 若有，返回1，否则返回0
function y=IsInMatrix(a,A);
[m,n]=size(A);
y=0;
for i=1:m
for j=1:n
if A(i,j)==a
y=1;
break;
end
end
if j<n
break;
end
end

%% 对处理过的每行每列都有零元素的矩阵C进行试指派
function y=TryAssign(C)
[m,n]=size(C);
while IsInMatrix(0,C)==1
flag=0;
for i=1:m       
if ZeroNumber(C(i,:))==1
temp=C(i,:);
ZeroRowPos=find(temp==0);
C(i,ZeroRowPos)=inf;   
temp=C(:,ZeroRowPos);
ZeroColPos=find(temp==0);
for j=ZeroColPos
C(j,ZeroRowPos)=-inf;  
end
flag=flag+1;
end
end
for i=1:n       
if ZeroNumber(C(:,i))==1
temp=C(:,i);
ZeroColPos=find(temp==0);
C(ZeroColPos,i)=inf;     
temp=C(ZeroColPos,:);
ZeroRowPos=find(temp==0);
for j=ZeroRowPos
C(ZeroColPos,j)=-inf;
end
flag=flag+1;
end
end
if flag==0        
temp=inf;
for i=1:m     
if (ZeroNumber(C(i,:))<temp) & (ZeroNumber(C(i,:))>0)
temp=ZeroNumber(C(i,:));
ZeroRow=i;
end
end
temp1=find(C(ZeroRow,:)==0);
temp2=inf;
for i=temp1     
if (ZeroNumber(C(:,i))<temp2) & (ZeroNumber(C(:,i))>0)
temp2=ZeroNumber(C(:,i));
ZeroCol=i;
end
end
C(ZeroRow,ZeroCol)=inf;
temp=find(C(ZeroRow,:)==0);
for i=temp      
C(ZeroRow,i)=-inf;
end
temp=find(C(:,ZeroCol)==0);
for i=temp
C(i,ZeroCol)=-inf;
end
end
end
y=C;

%% 用最少的直线覆盖所有零元素
function [y,Row,Col]=ZeroCover(C,Row,Col,Cur)
[m,n]=size(C);
temp=C(Cur,:);      
flag=0;
Cur=[];
for i=1:m
if temp(i)==-inf & Col(i)~=0      
Col(i)=0;
Cur=[Cur,i];
flag=1;
end
end
if flag==0                            
y=0;
else                                 
for i=Cur
temp=C(:,i);
for i=1:m
if temp(i)==inf & Row(i)==0   
Row(i)=1;
y=i;
flag=0;
[y,Row,Col]=ZeroCover(C,Row,Col,y);
break;
end
end
if flag==1       
y=0;
end
end
end

%%计算向量A中的零元素的个数
function y=ZeroNumber(A)
y=0;
for i=1:length(A)
if A(i)==0
y=y+1;
end
end