function [ ins ] = cv_setting(cv_num)

   num = 136;   
   p = ceil(num/cv_num);
   ins = {};
   set = 1:num;
   for i = 1 : cv_num - 1
       cur_pic = [];
       for j = 1 : p
           % pick a number
           ind = ceil(rand(1,1)*(length(set)-2))+1;
           cur_pic = [cur_pic; set(ind)]; %#ok<AGROW>
           set(ind) = [];
       end
       ins{i} = cur_pic; %#ok<AGROW>
   end
   
   ins{cv_num} = set';

end

