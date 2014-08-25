%�������㷨
function [y,fval,flag]=Hungary(C)%y���ص�������ֵ�����к�
%**************************************************************************
% �������������ָ������
% C��Ч�����
% M��ָ�ɾ���
% fval������ֵ
%  
% ���뻷����matlab 6.5   ����޸�ʱ�䣺     ��̣� �����
% 
% �÷���
%   [y,fval]=Hungary(A)
%   y=Hungary(A)
% ����˵��:
%   y:�õ�������ָ�ɾ���
%   fval:�õ�������ֵ
%   A:Ч�����
% ���� 
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
%%%��������ѭ��ʹÿ��ÿ�ж�������Ԫ��
for i=1:m
tempC(i,:)=tempC(i,:)-min(tempC(i,:));
end
for i=1:n
tempC(:,i)=tempC(:,i)-min(tempC(:,i));
end       
tempC=TryAssign(tempC); %��ÿ��ÿ�ж���������ľ����������              
OneNumber=0;%ÿ�ж�����ĸ���
for i=1:m                        
for j=1:n
if tempC(i,j)==inf
OneNumber=OneNumber+1;
break;
end
end
end
while OneNumber<m%�����������ɸ���С������
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
[Cur,Row,Col]=ZeroCover(tempC,Row,Col,Cur);%�����ٵ�ֱ�߸���������
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
tempC=TryAssign(tempC);%��������
OneNumber=0;%��������ĸ���
for i=1:m                        
for j=1:n
if tempC(i,j)==inf
OneNumber=OneNumber+1;
break;
end
end
end
end%while
AssignMatrix=zeros(m,n); %ָ�ɾ���
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

%% �жϾ���A���Ƿ���Ԫ��a
%% ���У�����1�����򷵻�0
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

%% �Դ������ÿ��ÿ�ж�����Ԫ�صľ���C������ָ��
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

%% �����ٵ�ֱ�߸���������Ԫ��
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

%%��������A�е���Ԫ�صĸ���
function y=ZeroNumber(A)
y=0;
for i=1:length(A)
if A(i)==0
y=y+1;
end
end