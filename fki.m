% Chengwei Liu, 2021, Imperial College.
% 04/01/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wavenumber vector in half wavelengths;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function KI = fki(az,el);

KI = pi*[cos(az).*cos(el)   sin(az).*cos(el)    sin(el)]';
