%此程序用于计算生成sij矩阵，即男对女的满意度矩阵
clc
clear all
load('bik.txt') %加载男生对女生基本要求
load('cjk.txt') %加载女生基本条件
B=bik; 
C=cjk; 
k=5; %设置哪个方面，K=1,2,3,4,5分别是外貌...五个方面
for j=1:10 %从女生条件矩阵第一行开始，也就是先选定一个女生
   for i=1:10 %从第一个男生的要求矩阵的第一行开始循环，也就是挑出第一位男生
    if (B(i,k)==C(j,k))%判断条件，根据sij计算法则，分类讨论
        S(i,j)=1
    elseif (B(i,k)>C(j,k))
        S(i,j)=-2^(B(i,k)-C(j,k))
    else S(i,j)=2^(C(j,k)-B(i,k))
    end
   end
end