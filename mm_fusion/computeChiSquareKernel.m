function K = computeChiSquareKernel(X)
% Input: X, a n * d-dimensional sample matrix;
% Input: c, const
% Output: K, a n * n-dimensional kernel matrix.

[n, d] = size(X);
K = eye(n);
for i = 1 : n
    fi = X(i,:);
    for j = i+1 : n
        fj = X(j,:);
        K(i,j) = 1 - sum((fi-fj).^2./(0.5*(fi+fj+(1e-7))));
        K(j,i) = K(i,j);
    end
end
        