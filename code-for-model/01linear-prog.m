%此程序用于整数线性规划计算最大值和相应矩阵最优解
clear all
load('rijlie.txt')%加载计算好的，男女双方的相互满意度，已经变成成列向量形式
load('xquanbu.txt')%加载线性规划中的等式约束的系数矩阵


ef=rijlie;
f=ef*(-1);
a=[];%线性规划中的不等式约束，本题没有故为空矩阵
b=[];
aeq=xquanbu;%线性规划中的等式约束的系数矩阵
beq=ones(20,1);%线性规划中等式约束中的右端值向量
[X,fval]=bintprog(f,a,b,aeq,beq);%0-1整数规划
fmax=-fval %返回最大值 
X %返回最大值对应的0-1矩阵，也就是配对的矩阵

