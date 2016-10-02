%% For simulation
clear all;
addpath functions
addpath simulinkfiles

%Speed of turtlebot
a = 0.2; %0.2 m/s

T = 0.1; %Actuator dynamics

% Stabilizing using LQ control.
% ADD CODE HERE START

L = [0 0]; 


%END


%%
% Generate a trajectory
%Sampling time generating path
Ts = 0.04; % Sampling time
Sim_time=30; % Simulation Time

% Inital position
thetainit =0; 
xinit=0;
yinit=0;
A=0.35; %input is a sinusioud with amp A 
w=0.3; %and frequency w.
sim('Simulation.slx');

%Save reference trajectory
xref=x_ref.Data(:,1);
yref=x_ref.Data(:,2);
thetaref=x_ref.Data(:,3);
u0=u0.Data;
save('RefTraj','xref','yref','thetaref','u0')


%% Test controller by pertub initial position

xinit=xref(1);
yinit=yref(1)-0.5;
thetainit=thetaref(1)-0.2;

Ts = 0.04;   % Sampling time
Sim_time=30; % Simulation Time (less then or equal to the simulated trajectory).

[x,y,theta,u0]  = get_ref();
ref = [x,y,theta,u0]; %load reference trajectory.
startIndex=1; % Where to start search for the projection onto the path.

sim('Simulation_with_controller.slx'); %simulate the system with the controller.

% Extract data from simulation
x=x_out.Data(:,1);
y=x_out.Data(:,2);
theta=x_out.Data(:,3);
u=u_out.Data;
N=length(x);
t2=x_out.Time;
error_states = p_tilde.Data;
Lx= feedback.Data;

%%
% Some fast plots
figure(1)
title('Feedback')
plot(t2,-Lx);
xlabel('t [s]','Interpreter','latex')
legend('-Lx')
figure(2);
plot(t2, error_states)
title('Error states')
xlabel('t [s]','Interpreter','latex')
legend('z','\theta_e')
figure(3)
plot(x,y);
hold on;
plot(xref,yref);
axis equal
ylabel('y [m]','Interpreter','latex')
xlabel('x [m]','Interpreter','latex')
legend('actual path','reference path')
hold off;

%%
%Grafic visualization write to a avi file defined by VideoWriter.
aviobj = VideoWriter('temp2.avi');
aviobj.FrameRate = 10; % How many frames per second.
open(aviobj);
%Number of samples N.

hFig = figure(14);
set(hFig, 'Position', [0 0 900 900])
plot_steering_anlge = 1;

accuracy = 1;
hold on

%For all samples N do grafical visualization.
for i=1:5:N
      
  
    hold off
    plot(xref,yref,'b')
    axis([-4 4 -4 4])
    hold on
    plot(x(1:i),y(1:i),'r--')
    plot_turtle_bot(x(i),y(i),theta(i));

    title('Simulation of turtle bot system.')
    ylabel('y [m]','Interpreter','latex')
    xlabel('x [m]','Interpreter','latex')
   
    frame = getframe(gcf);
    writeVideo(aviobj,frame);
end
close(aviobj); %Save the movie
hold off





