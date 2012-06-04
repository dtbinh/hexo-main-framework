%用matlab微分方程的数值解研究追截问题
clear all
clc 
format long g
tst=0;
tend=0;
%初始化微分方程参数
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
%绘制计算值与标准1.6的误差图
plot(1:length(x),abs(x(:,1)-c))

%输出数值解的计算结果
x(end,1)
 