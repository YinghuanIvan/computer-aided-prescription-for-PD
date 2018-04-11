function [ objv ] = calculate_objvalue_tran(P, U, V, X, Y, J)

   A = X*U-P;
   B = J*(Y-P*V);
   objv = norm(A,2)+norm(B,2);

end

