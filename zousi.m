%��matlab΢�ַ��̵���ֵ���о�׷������
clear all
clc 
format long g
tst=0;
tend=0;
%��ʼ��΢�ַ��̲���
a=35;
b=40;
c=15;

x=[0];
for i=1:20000
    if (abs(x(end,1)-c)<(10^-3)&&(1.6-t(end,1))<0.048)
    CatchTime=t(end,1)
    break
else 
    tend=i/100000+1.40;
[t,x]=ode45('fun',[tst,tend],[0 0]);
end
end
%���Ƽ���ֵ���׼1.6�����ͼ
plot(1:length(x),abs(x(:,1)-c))

%�����ֵ��ļ�����
x(end,1)
 