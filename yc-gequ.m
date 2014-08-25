load('gequyizhi.txt')
t=1:9
for i=1:6
    lh=gequyizhi(i,:)
    [fgequ,optew]=createfitd(t,lh)
    x=10:19
    N(:,i)=fgequ(x)
end