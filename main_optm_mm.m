function [ output ] = main_optm_mm(rX, rY, tX, tY, para)

   mod_num = length(rX);

   X = {};
   feat_num = zeros(mod_num,1);
   for i = 1 : mod_num
       X{i} = [rX{i}; tX{i}];
       feat_num(i) = size(X{i},2);
   end
   
   Y = [rY; tY];

   patient_num = size(Y,1);
   drug_num = size(Y,2);
   symp_num = para.symp_num;
   
   [U, P, V] = para_init_preload(patient_num, feat_num, drug_num, symp_num);
   
   J = eye(patient_num);
   for i = patient_num - size(tY,1) + 1 : patient_num
       J(i,i) = 0; 
   end
   objv = [];
   
   for iter = 1 : 300 
       % optimize U
       [U, ~] = opt_mm_U(P, U, V, X, Y, J, para);
       %objv1 = [objv1; o1(length(o1))];
       % optimize V
       %[V, o2] = opt_mm_V(P, U, V, X, Y, J, para);
       
       V = opt_mm_V_FISTA(V, para, P, Y);
       
       %objv1 = [objv1; o2(length(o2))];
       %tmp_obv1 = o2(length(o2));
       % optimize P
       [P, o3] = opt_mm_P(P, U, V, X, Y, J, para);       
       objv = [objv; o3(length(o3))]; %#ok<AGROW>
       if iter > 1
          tmp_obv2 = objv(length(objv));
          tmp_obv1 = objv(length(objv)-1);
          if abs(tmp_obv2 - tmp_obv1) < 0.001*tmp_obv1
             break;
          end
       end
   end
   
   output.U = U;
   output.V = V;
   output.P = P;
   output.X = X;
   output.Y = Y;
   output.obj = objv;
end

