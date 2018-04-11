function [U,P,V] = para_init(patient_num, feat_num, drug_num, symp_num)

   U = rand(feat_num, symp_num);
   P = rand(patient_num, symp_num);
   V = rand(symp_num, drug_num);

end

