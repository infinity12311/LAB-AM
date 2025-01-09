function gain = music(array, Rxx, M_source, m)
% MUSIC algorithm
p = size(Rxx,1);
if nargin<=3
    m = p; % for spatital smoothing techniques
end

% The eigenvalue decomposition of covariance matrix
[E, D] = eig(Rxx); % eigenvectors and eigenvalues
D = diag(D);
[~,i] = sort(D); % Sort the eigenvalue vector D in ascending order and return the sorted index
E = E(:,i); % The eigenvector matrix E is rearranged by index I

% Construct noise subspace
En = []; % eigenvectors of nosie subspace
for i=1:p-M_source
    En = [En E(:,p-M_source-i+1)];
end

gain = []; % gain according to different directions
for azimuth = 0:180
    S = spv(array,[azimuth,0]);
    S = S(1:m);
    gain = [gain 1/(S'*(En*En')*S)];
end

gain = 10*log10(gain);
end