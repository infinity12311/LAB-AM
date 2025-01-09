load Xaudio.mat
load Ximage.mat

%% superresolution Beamformer based on DOA estimation -------------------------------------30
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
% DOAs - 30, 35 and 90;
S = spv(array,directions);
Sd = S(:,1); % desired signal is 30

S_if = [S(:,2) S(:,3)]; % DOA of interference signal
%Projection matrix for the interference subspace
P_if = S_if*inv(S_if'*S_if)*S_if';
P_if_orth = eye(size(P_if))-P_if; % Orthogonal projection matrix

wsuper = P_if_orth*Sd;
Z = my_pattern(array, wsuper);
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-30^o, interference-35^o & 90^o)');

%Apply the weight on image signal
yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
displayimage(yt, image_size, 202,'The received signal at o/p of Superresolution Beamformer (desired-30^o)');

% superresolution Beamformer based on DOA estimation -------------------------------------- 35
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
% DOAs - 30, 35 and 90;
S = spv(array,directions);
Sd = S(:,2); % desired signal is 35

S_if = [S(:,1) S(:,3)]; % DOA of interference signal
%Projection matrix for the interference subspace
P_if = S_if*inv(S_if'*S_if)*S_if';
P_if_orth = eye(size(P_if))-P_if; % Orthogonal projection matrix

wsuper = P_if_orth*Sd;
Z = my_pattern(array, wsuper);
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-35^o, interference-30^o & 90^o)');

%Apply the weight on image signal
yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
displayimage(yt, image_size, 202,'The received signal at o/p of Superresolution Beamformer (desired-35^o)');

% superresolution Beamformer based on DOA estimation ----------------------------------------90
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
% DOAs - 30, 35 and 90;
S = spv(array,directions);
Sd = S(:,3); % desired signal is 35

S_if = [S(:,1) S(:,2)]; % DOA of interference signal
%Projection matrix for the interference subspace
P_if = S_if*inv(S_if'*S_if)*S_if';
P_if_orth = eye(size(P_if))-P_if; % Orthogonal projection matrix

wsuper = P_if_orth*Sd;
Z = my_pattern(array, wsuper);
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-90^o, interference-30^o & 35^o)');

%Apply the weight on image signal
yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
displayimage(yt, image_size, 202,'The received signal at o/p of Superresolution Beamformer (desired-90^o)');


%% not based on DOA estimation (Theoretical Signal)
% array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
% directions = [30, 0; 35, 0 ; 90, 0];
% S = spv(array,directions);
% sigma2 = 0.1; % noise power SNR=10dB
% 
% Rmm = eye(3); 
% Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); 
% Sd = S(:,2); % desired signale - 35
% 
% R_nJ = Rxx_theoretical - Sd*Sd';
% 
% [E, D] = eig(R_nJ);
% D = diag(D);
% [D,I] = sort(D,'descend');
% E = E(:,I);
% Ej = []; % eigenvectors of interference subspace
% Ej = E(:,1:2);
% 
% P_nJ = Ej*inv(Ej'*Ej)*Ej';
% P_nJ_orth = eye(size(P_nJ))-P_nJ;
% wsuper = P_nJ_orth*Sd;
% 
% Z = my_pattern(array, wsuper);
% plot2d3d(Z,[0:180],0,'gain in dB','Superresolution not based on estimation array pattern (desired-35^o)');
% %Apply the weight on image signal
% yt=wsuper'*X_im;
% yt = abs(yt);
% yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
% displayimage(yt, image_size, 202,'The received signal at o/p of Superresolution Beamformer (35^o)');