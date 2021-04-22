function y = preEmFilter(x)
%frequency response of a filter with differencial equation  y[n]=x[n]-0.95*x[x-1]
h=[1 -0.95];
y=filter(h,1,x);
end