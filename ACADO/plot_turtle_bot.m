function [] =     plot_turtle_bot(x,y,theta)
%UNTITLED3 Summary of this function goes here
%   Change comment to see where it ends up
%Correct lengths
L=0.2;
W=0.2;

    %plot bot
    P1 = [x + L*cos(theta) - W*sin(theta), y + L*sin(theta) + W*cos(theta)];
    P2 = [x + L*cos(theta) + W*sin(theta), y + L*sin(theta) - W*cos(theta)];
    P3 = [x - L*cos(theta) + W*sin(theta), y - L*sin(theta) - W*cos(theta)];
    P4 = [x - L*cos(theta) - W*sin(theta), y - L*sin(theta) + W*cos(theta)];
    xv=[%P1(1), ...
        P2(1), ...
        P3(1),...
        P4(1),...
        P1(1)];
    
    yv=[%P1(2), ...
        P2(2), ...
        P3(2),...
        P4(2),...
        P1(2)];
    xf = [P1(1),P2(1)];
    yf = [P1(2),  P2(2)];
    plot(xv,yv,'b');
    plot(xf,yf,'r');




tl=L/1.5; %length of wheel
h = W/1.5; %distance from wheel to center

%plot right tire
xv=[x + h*sin(theta) - tl/2*cos(theta), x + h*sin(theta) + tl/2*cos(theta)];
yv=[y - h*cos(theta) - tl/2*sin(theta), y - h*cos(theta) + tl/2*sin(theta)];
plot(xv,yv,'LineWidt',1,'color','k');

%plot left tire
xv=[x - h*sin(theta) - tl/2*cos(theta), x - h*sin(theta) + tl/2*cos(theta)];
yv=[y + h*cos(theta) - tl/2*sin(theta), y + h*cos(theta) + tl/2*sin(theta)];
plot(xv,yv,'LineWidt',1,'color','k');


end

