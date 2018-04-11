function [ m_hloss, m_oneerr, m_conv, m_rloss, m_pre, m_rec, m_acc, m_f1s ] = metric_compute(X,Y,P)

   num = size(X,1);
   
   % hamming loss
   m_hloss = 0;
   for i = 1 : num
       x = X(i,:);
       y = Y(i,:);
       c = sign(abs(x-y));
       m_hloss = m_hloss + sum(c)/(length(c)*num);
       clear c;
   end
   
   % one error & coverage
   m_oneerr = 0;
   m_conv = 0;
   for i = 1 : num
       x = X(i,:);
       y = Y(i,:);
       p = P(i,:);
       [s_x, ind] = pro_sort_func(p);
       if x(ind(1)) ~= y(ind(1))
          m_oneerr = m_oneerr + 1/num;
       end
       t = 1e3;
       for j = 1 : length(y)
           if y(j) == 1 && p(j) < t  
              tmp = j;
              t = p(j);
           end
       end
       for j = 1 : length(y)
           if p(tmp) == s_x(j)
              tmpx = j;
              break;
           end
       end
       m_conv = m_conv + tmpx/num;
   end
   m_conv = (m_conv - 1)/size(X,2);
   
   % ranking loss
   m_rloss = 0;
   for i = 1 : num
       %x = X(i,:);
       y = Y(i,:);
       p = P(i,:);
       for j = 1 : length(y)
           for k = 1 : length(y)
               if (y(j) == 1 && y(k) == 0 && p(k) > p(j))||(y(j) == 0 && y(k) == 1 && p(j) > p(k))
                  m_rloss = m_rloss + 1;
               end
           end
       end
   end
   m_rloss = m_rloss/(size(X,2)*size(X,2)*num);
   
   m_pre = 0;
   m_rec = 0;
   m_acc = 0;
   m_f1s = 0;
   g = 1e-10;
   for i = 1 : num
       x = X(i,:);
       y = Y(i,:);
       s1 = sum(sign(x.*y));
       s2 = sum(sign(x+y))+g;               
       m_pre = m_pre + s1/(sum(sign(x))+g);
       m_rec = m_rec + s1/(sum(sign(y))+g);
       m_acc = m_acc + s1/s2;
       m_f1s = m_f1s + (2*s1)/(sum(sign(x))+sum(sign(y))+g);
   end
   m_pre = m_pre/num;
   m_rec = m_rec/num;
   m_acc = m_acc/num;
   m_f1s = m_f1s/num;

end




