load '../Data/Indian_pines_corrected.mat'

[n, m, k] = size(indian_pines_corrected);
obs = reshape(indian_pines_corrected, [n*m, k]);

disp('Starting regular PCA');
[coeff,score,latent,tsquared,explained,mu] = pca(obs);
disp('Finished regular PCA');

disp('Starting weighted PCA');
[w_coeff,~,w_latent,~,w_explained] = pca(obs,'VariableWeights','variance');
disp('Finished weighted PCA');

disp('Processes completed');