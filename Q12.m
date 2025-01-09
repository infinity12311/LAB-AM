clc
clear all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
load Xaudio.mat
load Ximage.mat

%12.1.a WH beamformer
Rxx_au = X_au*X_au' / length(X_au(1,:));
Sd = spv(array, [90,0]);
wopt = inv(Rxx_au) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Wiener-Hopf array pattern for the audio signal (soucre isolated is (90^o, 0^o))');
%12.1.b
yt_au=wopt'*X_au;
soundsc(real(yt_au), 11025);

%12.2
Rxx_im = X_im*X_im' / length(X_im(1,:));
Sd = spv(array, [90,0]);
wopt = inv(Rxx_im) * Sd;
yt_im=wopt'*X_im;
yt_im = abs(yt_im);
yt_im = (yt_im-min(yt_im)) * 255/(max(yt_im)-min(yt_im)); % normalize the image to [0,255]
displayimage(yt_im, image_size, 202,'The received image with Wiener-Hopf beamformer (soucre isolated is (90^o, 0^o))');
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Wiener-Hopf array pattern for the image signal (soucre isolated is (90^o, 0^o))');

