% To be run from the ./Code/ directory
load('../Data/Indian_pines_corrected.mat');
load('../Data/Indian_pines_gt.mat');

% Get sizes
[n,m,k] = size(indian_pines_corrected);

% Reshape with obs in each column
obs = reshape(indian_pines_corrected,[k,n*m]);

% All groundtruths are the same for each band
test = indian_pines_gt(:, :, 1);

% All corn pixels have class 1, and everything else has class -1
for i = 1:n
    for j = 1:m
        if(test(i, j) == 2 || test(i, j) == 3 || test(i, j) == 4)
            test(i, j) = 1;
        else
            test(i, j) = -1;
        end
    end
end
test = reshape(test, [1, n*m]).';

% Run svm
[beta, c] = softsvm(obs,test,0.005);

%{
% convert output back into map
output = obs.' * beta + c;
finalCalc = zeros(21025, 1);

for i = 1:21025
    if output(i) > -1
        finalCalc(i) = 1;
    else
        finalCalc(i) = -1;
    end
end

finalPic = reshape(finalCalc, [n, m]);
imagesc(finalPic);
%}

% Plots softsvm
fig = figure;
plot(obs.'*beta+c, 'Color', 'red');
hold on;
plot(-1, 'color', 'blue');
hold on;
xlabel('Data point') % x-axis label
hold on;
ylabel('Value of observation * beta + c') % y-axis label
hold off;

print(fig,'softsvmImage','-dpng')
