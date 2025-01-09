%Coherent sources
%1
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0]; % locations of array sensors
directions = [30, 0; 35, 0 ; 90, 0]; % DOAs of sources
Z = my_pattern(array);  % array pattern: Weighted response of the array to incident signals from different directions

plot2d3d(Z,[0:180],0,'gain in dB','initial pattern');

%2
S=spv(array, directions) % Manifold Vector: The phase response received on each element when the signal arrives at the array from different directions

% sigma2 = 0.0001; % noise power 40dB 
sigma2 = 0.1; % noise power 10dB 

SNR_dB = 10*log10(1 / sigma2);
Rmm = [1 1 0; 1 1 0; 0 0 1]; %Correlation between individual signal sources
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); % covariance matirx of received signals / The noise is the independent uniformly distributed white noise on each sensor
M=3

%9 Music problem
% Theoritical
Z = music(array, Rxx_theoretical, M);
plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (theoritical & coherent signals) SNR=' num2str(SNR_dB) 'dB']);

%11 Smooth MUSIC
Z = smooth_music(array, Rxx_theoretical, M, 4);
plot2d3d(Z,[0:180],0,'gain in dB',['spatial Smoothing MuSIC spectrum (theoritical & coherent signals) SNR=' num2str(SNR_dB) 'dB']);
