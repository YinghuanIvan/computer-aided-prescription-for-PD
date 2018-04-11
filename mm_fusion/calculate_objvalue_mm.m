function [ objv ] = calculate_objvalue_mm(P, U, V, X, Y, J, para)

   tmp = 0;
   for i = 1 : length(U)
       A = X{i}*U{i}-P;
       tmp = tmp + norm(A,'fro')^2 + para.alpha*norm(U{i},'fro')^2;
       clear A;
   end
  
   B = J*(Y-P*V);
   objv = tmp + norm(B,'fro')^2 + para.beta*norm(V,1);

end

