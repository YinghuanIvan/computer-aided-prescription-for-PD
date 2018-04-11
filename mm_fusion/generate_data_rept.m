function [table_drug, datax] = generate_data_rept()

  [table_drug, table_sp1, table_sp2] = data_load_mm();
  x1 = data_normalize(table_sp1);
  x2 = data_normalize(table_sp2);
  
  x1 = [x1 x2];
  
  x3 = computeBKernel(x1);
  %x5 = computeChiSquareKernel(x1);
  %x7 = computeLinearKernel(x1,1e-5);
  x9 = computeRBFKernel(x1,0.01);
  
  datax{1} = x1;
  datax{2} = x3;
  datax{3} = x9;
  
end

