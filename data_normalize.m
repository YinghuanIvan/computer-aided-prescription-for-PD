function [ B ] = data_normalize( A ) 
   B = A;
   for i = 1 : size(A,2)
       s = A(:,i);
       t = (s - min(s))/(max(s)-min(s));
       B(:,i) = t;
   end
   clear A; 
end

