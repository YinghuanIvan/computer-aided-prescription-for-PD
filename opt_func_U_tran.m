function [ U_update, objv_array ] = opt_func_U_tran(P, U, V, X, Y, J)

   max_iter = 100;
   err_gap = 1e-4;
   alpha = 0.25;
   beta = 0.8;
   
   err = 1e4;
   iter = 0;
   
   U1 = U;
   objv_array = [];
   clear U;
   while err > err_gap && iter < max_iter
         iter = iter + 1;
         grad = X.'*(X*U1-P);
         step_size = 1;
         while calculate_objvalue_tran(P,U1-step_size*grad,V,X,Y,J) ...
                 > calculate_objvalue_tran(P,U1,V,X,Y,J) - alpha*step_size*norm(grad,2) 
               step_size = step_size*beta; 
         end
         U2 = U1 - step_size*grad;
         f1 = calculate_objvalue_tran(P,U1,V,X,Y,J);
         f2 = calculate_objvalue_tran(P,U2,V,X,Y,J);
         objv_array = [objv_array, f1]; %#ok<AGROW>
         fprintf('opt U - iteration %d\n',iter);
         U1 = U2;
         if f2 < f1
            err = f1-f2;
         end
   end
   
   U_update = U2;

end

