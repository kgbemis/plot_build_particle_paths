function test_eject_angle(v0,Raz,Maz,Rav,Mav)
% 3D Volcanic Eruptions - No Drag, Iterating with time
% tests landing distributions - based on the 12-7-18 build code


% Parameters that change frequently:
%v0=30; % initial velocity in meters per second
       % assumed uniform for each burst (phase)
w=1000; % width of landing space in meters
N=100; % number of particles per phase
% specification of ejection directions
bursttype='annulus';  % either 'annulus' or 'directed'  *annulus
%Maz=0; % controls direction (set to 0 for annulus)   *0
%Raz=360; % controls range of directions (set to 360 for annulus)   *360
%Mav=10; % controls angle from vertical (value must be btwn 0 and 90)   *15
        % actual value IS angle from horizontal
        % max distance traveled for given velocity at Mav=45deg
%Rav=5; % controls range of angle from vertical (value must be btwn 0 and 90)    *5

%Constants
g=9.8; % modified gravity
r=w/2; % horizontal distance (radius from the cone)
n=0; % n=number of iterations in loop computing particle paths
x0=r; % crater is in the middle
y0=r;
z0=0; % initial z position is zero
dtb=0.05; % time step for ballistic computations (seconds)

% wind parameters
thetaW=90; % wind direction
Uo=1; % wind speed

fprintf('setup done: %s\n',datestr(now))
% Ballistics stage ONLY -- find landing places based on ballistic paths
% SETUP Ejection Angles
switch bursttype
    case 'annulus'
        az = Maz+Raz*rand(1,N);  % note that this case uses uniform distribution here
        av = Mav+Rav*randn(1,N);
    case 'directed'
        az = Maz+Raz*randn(1,N);
        av = Mav+Rav*randn(1,N);
end
v0x=v0*cosd(av).*cosd(az)+Uo*cosd(thetaW); %initial x-velocity (adj by "wind")
v0y=v0*cosd(av).*sind(az)+Uo*sind(thetaW); %initial y-velocity (adj by "wind")
v0z=v0*sind(av); %initial z-velocity

z=@(t) z0+v0z.*t-0.5*g.*t.^2; %vertical particle path
x=@(t) x0+v0x.*t; % horizontal particle path
y=@(t) y0+v0y.*t; % horizontal particle path
vz=@(t) v0z-g*t; % vertical velocity along path

zpath=zeros(5/dtb,N); %makes empty matrix as placeholder
xpath=zeros(5/dtb,N); %makes empty matrix as placeholder
ypath=zeros(5/dtb,N); %makes empty matrix as placeholder
vzpath=zeros(5/dtb,N); %makes empty matrix as placeholder
for t=0:dtb:30 %looping with time with 0.5 second increments
    n=n+1; %counts number of loops
    zpath(n,:)=z(t);
    xpath(n,:)=x(t);
    ypath(n,:)=y(t);
    vzpath(n,:)=vz(t);
end

% find time index (n) for maximun height
maxz=max(zpath);
nis=zeros(N,1);
for i=1:N
    ni=find(abs(zpath(:,i)-maxz(i))<0.001);
    nis(i)=ni(1);
end
ni=max(nis);

% plot ballistic paths
myf=figure(1);
plot3(xpath(1:ni,:),ypath(1:ni,:),zpath(1:ni,:))
xlabel('x')
ylabel('y')
zlabel('z')
title([bursttype ': v0=' num2str(v0) ' Raz=' num2str(Raz) ' Maz=' num2str(Maz) ' Rav=' num2str(Rav) ' Mav=' num2str(Mav)]);
axis([x0-100 x0+100 y0-100 y0+100 z0 z0+100])
grid on
%figfilename=['eject_dist_v0' num2str(v0) '_Rav' num2str(Rav) '_Mav' num2str(Mav)];
%print(figfilename,'-dpng','-r600')
% for final figure
vecfilename=['eject_dist_v0' num2str(v0) '_Rav' num2str(Rav) '_Mav' num2str(Mav)];
%exportgraphics(myf,[vecfilename '_vec.eps'],'BackgroundColor','none','ContentType','vector')


