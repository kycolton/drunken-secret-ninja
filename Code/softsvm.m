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
    
% Create parameters for quadprog
    disp('Creating parameters for quadprog');

    [d, n] = size(X);    
    
    H = blkdiag(zeros(n), eye(d), 0);   
    f = horzcat(gamma * ones(1,n), zeros(1, d+1));  
    A = horzcat(-eye(n), -diag(Y)*X', -Y);
    b = -ones(n, 1);    
    lb = vertcat(zeros(n, 1), -inf(d+1, 1)); 
    
    disp('Finished created parameters for quadprog');
    
% Run quadprog
    disp('Starting quadprog');
    
    opts = optimoptions('quadprog','Algorithm','interior-point-convex');
    ybc = quadprog(H,f,A,b,[],[],lb,[],[],opts);
    
    disp('Finished quadprog');
    
% Final calculations
    disp('Starting beta and c calculations');
    
    beta = ybc(n+1:n+d, 1); 
    c = ybc(n+d+1, 1);
    
    disp('Finished beta and c calculations. Process completed successfully');

end