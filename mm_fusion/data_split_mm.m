function [ data ] = data_split_mm(cv_num, X, Y)

   ins = cv_setting(cv_num);
   mod_num = length(X);
   data = {};
   for i = 1 : cv_num
       test_ind = sort(ins{i});
       train_ind = [];
       for j = 1 : cv_num
           if j ~= i
              train_ind = [train_ind; ins{j}]; %#ok<AGROW>
           end
       end
       train_ind = sort(train_ind);
       for j = 1 : mod_num
           data{i,j}.trainX = X{j}(train_ind,:);
           data{i,j}.trainY = Y(train_ind,:);
           data{i,j}.testX = X{j}(test_ind,:);
           data{i,j}.testY = Y(test_ind,:);
       end
   end

end

