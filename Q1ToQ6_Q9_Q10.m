
%1
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0]; % locations of array sensors
directions = [30, 0; 35, 0 ; 90, 0]; % DOAs of sources
Z = my_pattern(array);  % array pattern: Weighted response of the array to incident signals from different directions

plot2d3d(Z,[0:180],0,'gain in dB','Initial Pattern');

%2
S=spv(array, directions) % Manifold Vector: The phase response received on each element when the signal arrives at the array from different directions

sigma2 = 0.0001; % noise power 40dB 
SNR_dB = 10*log10(1 / sigma2);
Rmm = eye(3); %Correlation between individual signal sources
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); % covariance matirx of received signals / The noise is the independent uniformly distributed white noise on each sensor

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

% 
%6 Estimated problem
%Wiener-Hopf algorithm
Sd = spv(array, [90,0]); % Steering vector: Used to generate array response vectors for specific directions
a=1 % gain factor of WIENER-HOPF Beamformer
wopt = a*inv(Rxx_theoretical) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB',['Wiener-Hopf theoretical array pattern SNR=',num2str(SNR_dB),'dB']);

%9 Music problem
% Theoritical
Z = music(array, Rxx_theoretical, M);
plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (theoritical & uncorrelated  signals) SNR=' num2str(SNR_dB) 'dB']);

%10
% audio signal
Z = music(array, Rxx_au, M);
plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum for audio signal']);
% % 
% image signal
Z = music(array, Rxx_im, M);
plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum for image signal']);








