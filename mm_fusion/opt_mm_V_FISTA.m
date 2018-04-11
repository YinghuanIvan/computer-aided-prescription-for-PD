function Vk = opt_mm_V_FISTA(V0, para, P, Y)%#codegen
    
    %min F(V) = f(V) + g(V) (smooth and nonsmooth L1)
    tol = 1e-3; k = 1; L0 = 1; eta = 2; beta = para.beta;
    Vk_1 = V0; Vk = V0; Zk = V0; tk = 1; Lk_1 = L0; 
    
    % L1-norm + smooth terms
   
        fvalue = norm(P*V0-Y,'fro')^2;

        Objk_1 = fvalue+beta*norm(V0(:),1);  Objlist = [];
        while 1
            % backtracking
            Ltmp = Lk_1;        
            while 1
                grad = 2*P'*(P*Zk-Y);
                D = Zk - grad/Ltmp;
                Vtmp = solveL1fun(D,beta/Ltmp);
                
                tmp = (Vtmp-Zk)'*grad;           
                fvalue = norm(P*Zk-Y,'fro')^2;
                value = fvalue + sum(diag(tmp)) + 0.5*Ltmp*norm(Vtmp-Zk,'fro')^2;

                fvalueV = norm(P*Vtmp-Y,'fro')^2;
                if fvalueV <= value                    
                    Lk = Ltmp;
                    Vk = Vtmp;
                    break;
                end
                Ltmp = Ltmp*eta;
            end
            % each iteration
            tkp1 = 0.5*(1+sqrt(1+4*tk^2));
            Zkp1 = Vk + (tk-1)/tkp1*(Vk-Vk_1);

            Objk = fvalueV+beta*norm(Vk(:),1);
            if abs(Objk-Objk_1)/(Objk_1) <= tol || k > 1000
                break;
            end 

            Objlist = [Objlist; Objk];
            Vk_1 = Vk; Zk = Zkp1; tk = tkp1; Lk_1 = Lk; Objk_1 = Objk;

            k = k + 1;
        end
        % disp(['k=' num2str(k) ', err=' num2str(abs(Objk-Objk_1)/(Objk_1))]);
end

function y = solveL1fun(x,alpha)
    T = alpha;
    if sum(abs(T(:)))==0
        y = x;
    else
%         y = max(abs(x) - T, 0);
%         y = sign(x).*y;
        y = max(x-T,0);
    end
end