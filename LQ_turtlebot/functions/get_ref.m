function [x,y,theta,u0] = get_ref()
%Function that stores reference path

ref=load('Reftraj');
x=ref.xref;
y=ref.yref;
theta=ref.thetaref;
u0=ref.u0;
end