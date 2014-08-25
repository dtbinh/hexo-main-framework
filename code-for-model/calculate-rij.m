%此程序用于计算男女双方相互的满意度rij
clc 
clear all
load('quandddjk.txt') %加载女生j在k方面的权重矩阵
load('quanbbbik.txt') %加载男生i在k方面的权重矩阵
load('aik.txt') %加载男生条件矩阵
load('bik.txt') %加载男生基本要求矩阵
load('cjk.txt') %加载女生条件矩阵
load('djk.txt') %加载女生基本要求矩阵
load('totalsij.txt') %加载男生对女生满意度矩阵
load('totaltji.txt') %加载女生对男生满意度矩阵

for k=1:5 %循环计算五大方面，即外貌等

b=quanbbbik(10*k-9:10*k,:);
b1=b';
d=quandddjk(10*k-9:10*k,:);
d1=d';
sij=totalsij(10*k-9:10*k,:)'
tji=totaltji(10*k-9:10*k,:)'
zuihou{1,k}=b1*sij+d1*tji;%根据rij的计算法则，计算出男女双方满意度矩阵，返回保存在‘zuihou’这个元胞数组中

end