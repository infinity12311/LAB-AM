% Change 40dB to 10dB
%1
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0]; % locations of array sensors
directions = [30, 0; 35, 0 ; 90, 0]; % DOAs of sources
Z = my_pattern(array);  % array pattern

plot2d3d(Z,[0:180],0,'gain in dB','initial pattern');

%2
S=spv(array, directions)

sigma2 = 0.1; % noise power 10dB 
SNR_dB = 10*log10(1 / sigma2);
Rmm = eye(3); 
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); % covariance matirx of received signals

%3
load Xaudio.mat
load Ximage.mat
 
soundsc(abs(X_au(2,:)), 11025)
displayimage(X_im(2,:),image_size, 201,'The received signal at the 2nd antenna')

% covariance matrix in practice
Rxx_au = X_au*X_au' / length(X_au(1,:));
Rxx_im = X_im*X_im' / length(X_im(1,:));

%4
%estimated parameters
directions = [];
Rmm = [];
S = [];
sigma2 = [];

%5 Detection problem
eig_theoretical = eig(Rxx_theoretical);
eig_au = eig(Rxx_au);
eig_im = eig(Rxx_im);
M = 3;

%6 Estimated problem
Sd = spv(array, [90,0]);
wopt = inv(Rxx_theoretical) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB',['Wiener-Hopf theoretical array pattern SNR=',num2str(SNR_dB),'dB']);

%9 Music problem
% Theoritical
Z = music(array, Rxx_theoretical, M);
plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (theoritical & uncorrelated signals) SNR=' num2str(SNR_dB) 'dB']);