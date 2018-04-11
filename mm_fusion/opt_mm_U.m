function [ U_update, objv_array ] = opt_mm_U(P, U, V, X, Y, J, para)

   max_iter = 200;
   objv_array = [];
   U_update = U;
   mod_num = length(U);
   for ind = 1 : mod_num
       alpha = 0.25;
       beta = 0.8;
       iter = 0;
       U1 = U_update;
       while iter < max_iter
             iter = iter + 1;
             grad = X{ind}.'*(X{ind}*U1{ind}-P) + para.alpha*U1{ind};
             step_size = 1;
             UC = U1;
             UC{ind} = U1{ind}-step_size*grad; 
             while calculate_objvalue_mm(P,UC,V,X,Y,J,para) ...
                  > calculate_objvalue_mm(P,U1,V,X,Y,J,para) - alpha*step_size*norm(grad,2) 
                   step_size = step_size*beta; 
                   UC{ind} = U1{ind}-step_size*grad;
             end
             clear UC;
             U2 = U1;
             U2{ind} = U1{ind} - step_size*grad;
             f1 = calculate_objvalue_mm(P,U1,V,X,Y,J,para);
             f2 = calculate_objvalue_mm(P,U2,V,X,Y,J,para);
             objv_array = [objv_array, f1]; %#ok<AGROW>
             %fprintf('opt U - iteration %d\n',iter);
             U1 = U2;
             if f2 < f1 && f1-f2 < f1*0.001
                break;
             end
       end
       U_update{ind} = U2{ind};
       clear U2;
   end

end

