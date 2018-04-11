
clear;
load opt2.mat;

U = opt.U;
V = opt.V;
X = opt.X;
Y = opt.Y;

M = X*U*V;

H = sign(sign(M-0.5)+1);
[ m_hloss, m_oneerr, m_conv, m_rloss, m_pre, m_rec, m_acc, m_f1s ] = metric_compute(H,Y,M);

% subplot(1,3,1);imshow(Y),subplot(1,3,2);imshow(H);subplot(1,3,3);imshow(abs(Y-H))