%�˳������ڼ�����Ů˫���໥�������rij
clc 
clear all
load('quandddjk.txt') %����Ů��j��k�����Ȩ�ؾ���
load('quanbbbik.txt') %��������i��k�����Ȩ�ؾ���
load('aik.txt') %����������������
load('bik.txt') %������������Ҫ�����
load('cjk.txt') %����Ů����������
load('djk.txt') %����Ů������Ҫ�����
load('totalsij.txt') %����������Ů������Ⱦ���
load('totaltji.txt') %����Ů������������Ⱦ���

for k=1:5 %ѭ����������棬����ò��

b=quanbbbik(10*k-9:10*k,:);
b1=b';
d=quandddjk(10*k-9:10*k,:);
d1=d';
sij=totalsij(10*k-9:10*k,:)'
tji=totaltji(10*k-9:10*k,:)'
zuihou{1,k}=b1*sij+d1*tji;%����rij�ļ��㷨�򣬼������Ů˫������Ⱦ��󣬷��ر����ڡ�zuihou�����Ԫ��������

end