% Iterates through the Indian Pines file and produces an image for each band

for i = 1:size(indian_pines_corrected)(3)
	imagesc(indian_pines_corrected(:,:,i));
	pause(1)
end

