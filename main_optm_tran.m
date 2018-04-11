function [ output ] = main_optm_tran(X, Y, tX, tY)

   X = [X; tX];
   Y = [Y; tY];

   patient_num = size(X,1);
   feat_num = size(X,2);
   drug_num = size(Y,2);
   symp_num = 50;

   [U, P, V] = para_init_preload(patient_num, feat_num, drug_num, symp_num);
   
   J = eye(patient_num);
   for i = patient_num - size(tX,1) + 1 : patient_num
       J(i,i) = 0; 
   end
   objv1 = [];
   
   for iter = 1 : 3  
       % optimize U
       [U, o1] = opt_func_U_tran(P, U, V, X, Y, J);
       objv1 = [objv1; o1(length(o1))];
       % optimize V
       [V, o2] = opt_func_V_tran(P, U, V, X, Y, J);
       objv1 = [objv1; o2(length(o2))];
       % optimize P
       [P, o3] = opt_func_P_tran(P, U, V, X, Y, J);
       objv1 = [objv1; o3(length(o3))];
   end
   
   output.U = U;
   output.V = V;
   output.P = P;
   output.X = X;
   output.Y = Y;
   output.obj = objv1;
end

