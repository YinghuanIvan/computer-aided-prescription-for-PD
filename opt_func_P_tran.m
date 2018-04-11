function [ P_update, objv_array ] = opt_func_P_tran(P, U, V, X, Y, J)

   max_iter = 100;
   err_gap = 1e-4;
   alpha = 0.25;
   beta = 0.8;
   
   err = 1e4;
   iter = 0;
   
   P1 = P;
   objv_array = [];
   clear P;
   while err > err_gap && iter < max_iter
         iter = iter + 1;
         grad = -(X*U-P1)-J*(Y-P1*V)*V.';                 
         step_size = 1;
         while calculate_objvalue_tran(P1-step_size*grad,U,V,X,Y,J)...
                 > calculate_objvalue_tran(P1,U,V,X,Y,J) - alpha*step_size*norm(grad,2) 
               step_size = step_size*beta; 
         end
         P2 = P1 - step_size*grad;
         f1 = calculate_objvalue_tran(P1,U,V,X,Y,J);
         f2 = calculate_objvalue_tran(P2,U,V,X,Y,J);
         objv_array = [objv_array, f1]; %#ok<AGROW>
         fprintf('opt P - iteration %d\n',iter);
         P1 = P2;
         if f2 < f1
            err = f1-f2;
         end
   end
   
   P_update = P2;



end

