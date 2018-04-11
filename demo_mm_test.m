clear;
clc;
[table_drug, datax] = generate_data_rept();

X = {};
mod_num = length(datax);
for i = 1 : mod_num
    X{i} = data_normalize(datax{i});
end

%X = data_normalize(x1);
Y = table_drug;

cv_num = 10;
D = data_split_mm(cv_num, X, Y);

result = [];

para.alpha = 1e3; %1e-3;
para.beta = 1e-1; %1e-3;
para.symp_num = 50;

for i = 1 : cv_num
    trainX = {};
    for j = 1 : mod_num
        trainX{j} = D{i,j}.trainX;
        testX{j} = D{i,j}.testX;
    end
    
    trainY = D{i,1}.trainY;
    testY = D{i,1}.testY;
    
    opt = main_optm_mm(trainX, trainY, testX, testY, para);
    U = opt.U;
    V = opt.V;
    M = zeros(size(testY));
    for j = 1 : mod_num
        M = M + testX{j}*U{j}*V;
    end
    
    H = sign(sign(M-0.5)+1);
    [ m_hloss, m_oneerr, m_conv, m_rloss, m_pre, m_rec, m_acc, m_f1s ]...
        = metric_compute(H,testY,M);
    result = [result; [ m_hloss, m_oneerr, m_conv, m_rloss, m_pre,...
        m_rec, m_acc, m_f1s ]]; %#ok<AGROW>
end
