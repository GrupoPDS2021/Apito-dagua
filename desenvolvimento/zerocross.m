function n = zerocross(x);
z = x.';
n=0;
for i = 1 : size(z)-1
    sig = z(i) * z(i+1);
    if sig < 0
        n = n+1;
    end
end
end
