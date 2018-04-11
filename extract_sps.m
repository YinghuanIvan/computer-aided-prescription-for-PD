function [ table_sp ] = extract_sps( data, st_ind, ed_ind, x )

    table_sp = zeros(size(data,1)-1,ed_ind-st_ind+1); 
    
    for i = 2 : size(data,1)  
        for j = st_ind : ed_ind
            if ~isempty(data{i,j})
               %fprintf('%d,%d\n',i,j); 
               if x == 0
                  table_sp(i-1,j-st_ind+1) = str2num(data{i,j}(1));   %#ok<ST2NM>
               else
                  if isempty(data{i,j}(1))
                     table_sp(i-1,j-st_ind+1) = str2num(data{i,j}(2));   %#ok<ST2NM>
                  else
                     table_sp(i-1,j-st_ind+1) = str2num(data{i,j});   %#ok<ST2NM>
                  end
               end
            end
        end
    end

    %size(table_sp)

end

