function K = computeRBFKernel(X, gamma)
% Input: X, a n * d-dimensional sample matrix;
% Output: K, a n * n-dimensional kernel matrix.

[n, ~] = size(X);
K = eye(n);
for i = 1:n
    fi = X(i,:);
    for j = i+1:n
        fj = X(j,:);
        K(i,j) = exp(-gamma*sum((fi-fj).^2));
        K(j,i) = K(i,j);
    end
end
        