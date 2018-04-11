function [ a, ind ] = pro_sort_func(x)

  a = sort(x,'descend');
  mak = zeros(length(x),1);
  ind = zeros(size(x));
  for i = 1 : length(a)
      for j = 1 : length(x)
          if a(i) == x(j) && mak(j) == 0
             mak(j) = 1;
             ind(i) = j;
             break;
          end
      end
  end
  

end

