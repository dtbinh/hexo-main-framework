clc
clear all
      
       a0 =     0.03987 
       a1 =   -0.005528  
       b1 =   -0.006371  
       w =      0.2332 
      
for x=12:1:21
     i=x-11
  age(:,i)=    a0 + a1*cos(x*w) + b1*sin(x*w)
;
  age'
      end