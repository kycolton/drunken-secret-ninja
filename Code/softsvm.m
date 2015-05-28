%% SOFT Support Vector Machine
%%  Learns an approximately separating hyperplane for the provided data.
%% Inputs - 
%%  X - Matrix with observations in each column.
%%  Y - Vector of length equal to the number of columns of X, with either a 1 or -1 
%%     indicating the class label.
%%  gamma - Slack penalty parameter. Higher implies greater violation penalty.
%% Outputs - 
%%  beta - Normal vector for the output hyperplane (plane equation is <beta,x> + c = 0)
%%  c - Constant offset for the output hyperplane.

function [beta, c] = softsvm(X, Y, gamma)
    [d,n] = size(X);
    H = spdiags([zeros(n,1);ones(d,1);0], 0, n+d+1, n+d+1);
    A = [-speye(n),-diag(Y) * X', -Y];
    b = -ones(n,1);
    f = [repmat(gamma,1,n), zeros(1,d+1)];
    lb = [zeros(n,1);-Inf(d+1,1)];
    options = optimoptions('quadprog','Algorithm','interior-point-convex');
    x = quadprog(H,f,A,b,[],[],lb,[],[],options);
    beta = x(n+1:n+d);
    c = x(n+d+1);
end
