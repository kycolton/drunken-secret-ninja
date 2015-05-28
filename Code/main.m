% To be run from the ./Code/ directory
load('../Data/Indian_pines_corrected.mat');

% Get sizes
[n,m,k] = size(indian_pines_corrected);

% Reshape with obs in each column
obs = reshape(indian_pines_corrected,[k,n*m])';

% SVM SHOULD BE REWRITTEN FOR MORE CLASSES
[beta, c] = softsvm(obs,2*randi([1,2],1,n*m)-3,0.005);