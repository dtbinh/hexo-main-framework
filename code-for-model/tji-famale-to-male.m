%此程序用于计算tji，也即女生对男生的满意度矩阵
clc
clear all
load('aik.txt')%加载男生基本条件矩阵
load('djk.txt')%加载女生基本要求矩阵
A=aik;
D=djk;
k=1;%k=1,2,3,4,5,分别表示外貌等五大方面
for j=1:10 %从女生基本要求矩阵的第一行开始，也即选取第一个女生的要求
   for i=1:10 %从男生的基本条件矩阵的第一行开始，也即选取第一个男生的条件
    if (A(i,k)==D(j,k)) %根据tji的计算法则，分类求解
        T(j,i)=1
    elseif (D(i,k)>A(j,k))
        T(j,i)=-2^(A(i,k)-D(j,k))
    else T(j,i)=2^(A(j,k)-D(i,k))
    end
   end
end