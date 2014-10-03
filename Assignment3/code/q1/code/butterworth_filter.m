function [filter] = butterworth_filter(n, d)
filter = zeros(n, n);
u = [n/2, n/2];
for i=1:n
    for j=1:n
        a = norm(u - [i, j]);
        filter(i, j) = 1/(1 + (a/d)^4);
    end
end
%filter = fftshift(filter);