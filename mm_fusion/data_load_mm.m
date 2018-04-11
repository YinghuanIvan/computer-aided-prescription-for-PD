function [ table_drug, table_sp1, table_sp2 ] = data_load_mm()
   
  load data.mat;
  
  table_drug = zeros(size(data,1)-1,31); %#ok<USENS>
  
  for i = 2 : size(data,1)  
      for j = 12 : 42
          if ~isempty(data{i,j})
             table_drug(i-1,j-11) = 1;               
          end
      end
  end
  
  table_sp1 = extract_sps(data,44,98,0);
  
  table_sp2 = extract_sps(data,102,131,0);
  table_sp2 = [table_sp2 extract_sps(data,135,149,1)];
  table_sp2 = [table_sp2 extract_sps(data,153,172,0)];
  table_sp2 = [table_sp2 extract_sps(data,176,189,0)];
  table_sp2 = [table_sp2 extract_sps(data,193,217,0)];
  table_sp2 = [table_sp2 extract_sps(data,220,258,0)];
  
      
end

