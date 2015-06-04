load '../Data/Indian_pines_corrected.mat'

[n, m, k] = size(indian_pines_corrected);

obs = reshape(indian_pines_corrected, [n*m, k]);

[coeff,score,latent] = pca(obs);

% plots using entire data set
% mapcaplot(reshape(indian_pines_corrected, [n*m, k]));