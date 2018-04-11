function [U,P,V] = para_init_preload(~, feat_num, drug_num, symp_num)

   load opt2.mat;
   mod_num = length(feat_num);
   U = {};
   for i = 1 : mod_num
       U{i} = rand(feat_num(i), symp_num);
   end   
   %P = rand(patient_num, symp_num);
   P = opt.P;
   V = rand(symp_num, drug_num);

end

