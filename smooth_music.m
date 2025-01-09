function gain = smooth_music(array, Rxx, M_source, m)
% MUSCI algprithm with spatitial smoothing technique

p = size(Rxx, 1);
M = p-m+1;
Rxxs = zeros(m,m);
for i=1:M
    Rxxs=Rxxs+Rxx(i:i+m-1,i:i+m-1);
end
Rxxs = Rxxs/M; % smoothed covariance matrix

gain = music(array, Rxxs, M_source, m);
end