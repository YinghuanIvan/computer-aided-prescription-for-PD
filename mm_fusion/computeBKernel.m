function K = computeBKernel(X)
% Input: X, a n * d-dimensional sample matrix;
% Output: K, a n * n-dimensional kernel matrix.

[n, ~] = size(X);
K = eye(n);
for i = 1:n
    fi = X(i,:);
    mu1 = mean(fi);
    sigma1 = var(fi);
    for j = i+1:n
        fj = X(j,:);
        mu2 = mean(fj);
        sigma2 = var(fj);       
        temp = sigma1^2 + sigma2^2;
        if temp > 0
            K(i,j) = sqrt(2*sigma1*sigma2/temp)*exp(-0.25*(mu1-mu2)^2/temp);
            K(j,i) = K(i,j);
        end
    end
end
        