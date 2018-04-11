function [ P_update, objv_array ] = opt_func_P(P, U, V, X, Y)

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
         grad = -(X*U-P1)-(Y-P1*V)*V.';                 
         step_size = 1;
         while calculate_objvalue(P1-step_size*grad,U,V,X,Y) > calculate_objvalue(P1,U,V,X,Y) - alpha*step_size*norm(grad,2) 
               step_size = step_size*beta; 
         end
         P2 = P1 - step_size*grad;
         f1 = calculate_objvalue(P1,U,V,X,Y);
         f2 = calculate_objvalue(P2,U,V,X,Y);
         objv_array = [objv_array, f1]; %#ok<AGROW>
         fprintf('opt P - iteration %d\n',iter);
         P1 = P2;
         if f2 < f1
            err = f1-f2;
         end
   end
   
   P_update = P2;



end

