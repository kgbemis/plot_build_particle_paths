% run  test_eject_angle.m

% setup
v0=30; % initial velocity in meters per second
       % assumed uniform for each burst (phase)
%w=1000; % width of landing space in meters
%N=100; % number of particles per phase
% specification of ejection directions
%bursttype='annulus';  % either 'annulus' or 'directed'  *annulus
Maz=0; % controls direction (set to 0 for annulus)   *0
Raz=360; % controls range of directions (set to 360 for annulus)   *360
Mav=55; % controls angle from vertical (value must be btwn 0 and 90)   *15
        % actual value IS angle from horizontal
        % max distance traveled for given velocity at Mav=45deg
Rav=5; % controls range of angle from vertical (value must be btwn 0 and 90)    *5

%loop
for i=1:length(Mav)
    test_eject_angle(v0,Raz,Maz,Rav,Mav(i))
end

