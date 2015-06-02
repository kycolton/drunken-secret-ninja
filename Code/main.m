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

% convert output back into map
final = obs.' * beta + c;
re = zeros(21025, 1);

for i = 1:21025
    if final(i) > -1
        re(i) = 1;
    else
        re(i) = -1;
    end
end

blah = reshape(re, [n, m]);
imagesc(blah);

% error here

% Plots softsvm

fig = figure;
plot(obs.'*beta+c, 'Color', 'red');
hold on;
legend('obs * beta + c', 'Location', 'southoutside');
hold off;
