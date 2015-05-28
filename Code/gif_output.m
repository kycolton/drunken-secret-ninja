% Iterates through the Indian Pines file and produces a gif for each band

fname = 'indian_pines.gif';
fps = 24;
fh = figure(1);

for i = 1:size(indian_pines_corrected)(3)
    imagesc(indian_pines_corrected(:,:,i));
    drawnow;
    f = getframe(fh)
    im = frame2im(f)
    [imind,cm] = rgb2ind(im,256)
    if i == 1;
        imwrite(imind,cm,fname,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,fname,'gif','WriteMode','append','DelayTime',1/fps)
    end
end

