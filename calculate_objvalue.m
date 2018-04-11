function [ objv ] = calculate_objvalue(P, U, V, X, Y)

   A = X*U-P;
   B = Y-P*V;
   objv = norm(A,2)+norm(B,2);

end

