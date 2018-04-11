function [ P_update, objv_array ] = opt_mm_P(P, U, V, X, Y, J, para)

   % setting as constant
   max_iter = 200;
   %err_gap = 1e-4;
   alpha = 0.25;
   beta = 0.8;
   
   mod_num = length(X);
   
   %err = 1e4;
   iter = 0;
   
   P1 = P;
   objv_array = [];
   clear P;
   while iter < max_iter
         iter = iter + 1;
         tmp = zeros(size(P1));
         for j = 1 : mod_num
             tmp = tmp-(X{j}*U{j}-P1);
         end
         grad = tmp-J*(Y-P1*V)*V.';                 
         step_size = 1;
         while calculate_objvalue_mm(P1-step_size*grad,U,V,X,Y,J,para)...
                 > calculate_objvalue_mm(P1,U,V,X,Y,J,para) - alpha*step_size*norm(grad,2) 
               step_size = step_size*beta; 
         end
         P2 = P1 - step_size*grad;
         f1 = calculate_objvalue_mm(P1,U,V,X,Y,J,para);
         f2 = calculate_objvalue_mm(P2,U,V,X,Y,J,para);
         objv_array = [objv_array, f1]; %#ok<AGROW>
         fprintf('opt P - iteration %d\n',iter);
         P1 = P2;
         if f2 < f1 && f1-f2 < f1*0.001
            break;
         end
   end
   
   P_update = P2;



end

