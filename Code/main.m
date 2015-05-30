% To be run from the ./Code/ directory
load('../Data/Indian_pines_corrected.mat');

% Get sizes
[n,m,k] = size(indian_pines_corrected);

% Reshape with obs in each column
obs = reshape(indian_pines_corrected,[k,n*m])';

% SVM SHOULD BE REWRITTEN FOR MORE CLASSES

% runs soft SVM for observations
A = 2*randi([1,2],1,n*m)-3;
[beta, c] = softsvm(obs.',A.',0.005);

% plots softsvm
fig = figure;
plot(obs*beta+c, 'Color', 'red');
hold on;
legend('obs * beta + c', 'Location', 'southoutside');
hold off;

% saves figure as .png
print(fig,'softsvmImage','-dpng')

% runs k-means for 10 observations
[C, labels] = km(obs.', 10);
