% To be run from the ./Code/ directory
load('../Data/Indian_pines_corrected.mat');

% Get sizes
[n,m,k] = size(indian_pines_corrected);

% Reshape with obs in each column
obs = reshape(indian_pines_corrected,[k,n*m])';

% SVM SHOULD BE REWRITTEN FOR MORE CLASSES

A = 2*randi([1,2],1,n*m)-3;
%size(obs.')
%size(A.')

[beta, c] = softsvm(obs.',A.',0.005);

size(A)
size(beta)
size(c)

figure;
plot(A*beta+c, 'Color', 'red');
hold on;
plot(L, 'Color', 'blue');
legend('A' * beta + c', 'L', 'Location', 'southoutside');
hold off;