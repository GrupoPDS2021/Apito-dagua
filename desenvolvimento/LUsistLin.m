function x = LUsistLin(A,b)
    n = size(A,1);
    for k = 1:n-1
       for i = k+1:n
           if A(i,k)   ~= 0.0
               m = A(i,k)/A(k,k);
               A(i,k+1:n) = A(i,k+1:n) - m*A(k,k+1:n);
               A(i,k) = m;
           end
       end
    end
    if size(b,2) > 1; b = b'; end
    nn = length(b);
    for j = 2:nn
        b(j) = b(j) - A(j,1:j-1)*b(1:j-1);
    end
    for j = nn:-1:1
        b(j) = (b(j) - A(j,j+1:nn)*b(j+1:nn))/A(j,j);
    end
    x = b;
end