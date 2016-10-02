function aviobj = simulate_turtlebot(x_out, y_out, theta_out,video_name)

%Grafic visualization write to a avi file defined by VideoWriter.
aviobj = VideoWriter(video_name);
aviobj.FrameRate = 10; % How many frames per second.
open(aviobj);
%Number of samples N.

hFig = figure(14);
set(hFig, 'Position', [0 0 900 900])
plot_steering_anlge = 1;

accuracy = 1;
hold on
N = length(theta_out);
%For all samples N do grafical visualization.
for i=1:N
     
    figure(14)
    axis([-1.5 1.5 -1.5 1.5])
    hold on
    plot(x_out(1:i),y_out(1:i),'r--')
    plot_turtle_bot(x_out(i),y_out(i),theta_out(i));

    title('Simulation of turtle bot system.')
    ylabel('y [m]','Interpreter','latex')
    xlabel('x [m]','Interpreter','latex')
    
    frame = getframe(gcf);
    writeVideo(aviobj,frame);
    
end
close(aviobj); %Save the movie
hold off