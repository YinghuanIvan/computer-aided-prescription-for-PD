function [ data ] = data_split(cv_num, X, Y)

   ins = cv_setting(cv_num);
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
       data{i}.trainX = X(train_ind,:);
       data{i}.trainY = Y(train_ind,:);
       data{i}.testX = X(test_ind,:);
       data{i}.testY = Y(test_ind,:);
   end

end

