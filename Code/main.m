% To be run from the ./Code/ directory
load('../Data/Indian_pines_corrected.mat');

% Get sizes
[n,m,k] = size(indian_pines_corrected);

% Reshape with obs in each column
obs = reshape(indian_pines_corrected,[k,n*m])';

% SVM SHOULD BE REWRITTEN FOR MORE CLASSES

A = 2*randi([1,2],1,n*m)-3;

[beta, c] = softsvm(obs.',A.',0.005);

fig = figure;
plot(obs*beta+c, 'Color', 'red');
hold on;
legend('obs * beta + c', 'Location', 'southoutside');
hold off;

print(fig,'softsvmImage','-dpng')
