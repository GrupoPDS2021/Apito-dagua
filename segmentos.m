function z = segmentos(audioIn,y)

t1 = 20*44,1;
var = 1;
for i = 1:length(y)
    k = y(i,1);
while (k < y(i,2))
    z(:,var) = audioIn(k:k+t1);
    plot(k:k+t1,z(:,var))
    hold on
    k = k + t1;
    var = var +1;
    
end

end