function K = computeLinearKernel(X,c)
% Input: X, a n * d-dimensional sample matrix;
% Input: c, const
% Output: K, a n * n-dimensional kernel matrix.

[n, d] = size(X);
K = eye(n);
for i = 1:n
    fi = X(i,:);
    for j = i:n
        fj = X(j,:);
        K(i,j) = fi*fj'+c;
        K(j,i) = K(i,j);
    end
end
        