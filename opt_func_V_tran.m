function [ V_update, objv_array ] = opt_func_V_tran(P, U, V, X, Y, J)

   max_iter = 100;
   err_gap = 1e-4;
   alpha = 0.25;
   beta = 0.8;
   
   err = 1e4;
   iter = 0;
   
   V1 = V;
   objv_array = [];
   clear V;
   while err > err_gap && iter < max_iter
         iter = iter + 1;
         grad = -P.'*J*(Y-P*V1);                  
         step_size = 1;
         while calculate_objvalue_tran(P,U,V1-step_size*grad,X,Y,J) ...
                 > calculate_objvalue_tran(P,U,V1,X,Y,J) - alpha*step_size*norm(grad,2) 
               step_size = step_size*beta; 
         end
         V2 = V1 - step_size*grad;
         f1 = calculate_objvalue_tran(P,U,V1,X,Y,J);
         f2 = calculate_objvalue_tran(P,U,V2,X,Y,J);
         objv_array = [objv_array, f1]; %#ok<AGROW>
         fprintf('opt V - iteration %d\n',iter);
         V1 = V2;
         if f2 < f1
            err = f1-f2;
         end
   end
   
   V_update = V2;

end

