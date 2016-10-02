%% Optimal control using ACADO, minimum energy problem
clear;

BEGIN_ACADO;                                % Always start with "BEGIN_ACADO". 
    
    acadoSet('problemname', 'turtlebot_energy');   % Set your problemname. If you 
                                                   % skip this, all files will
                                                   % be named "myAcadoProblem"
    
    
    DifferentialState       x;              % The differential states, add turtlebot states
        
    Control                 ...;              % The control signals, add

    
    % Differential Equation
    f = acado.DifferentialEquation();       % Set the differential equation object
    
    f.add(dot(x) == ...);  % Write down your equations. You can add 
                           % multiple ODE's and DAE's with f.add()  

    

    
    % Optimal Control Problem
    tStart = 0.0;                           % Set up the Optimal Control Problem (OCP)
    tEnd = ...;                             % Start at 0s, control in 40
    intervals = 40;                         % intervals upto xx s  
    ocp = acado.OCP(tStart, tEnd, intervals);          
                                            
    ocp.minimizeLagrangeTerm((1/2)*u*u);               % Minimize a Lagrange term
    
    ocp.subjectTo( f );                     % Your OCP is always subject to your 
                                            % differential equation                                  
    ocp.subjectTo( 'AT_START', x == ... );  % Initial conditions

    ocp.subjectTo( 'AT_END', x == ... );    % Terminal conditions
    
    ocp.subjectTo(... <= x <= ...);         % You can also add constraints
                                            % on the states and control signals 
    % Optimization Algorithm
    algo = acado.OptimizationAlgorithm(ocp); % Set up the optimization algorithm
    
    algo.set('KKT_TOLERANCE', 1e-5 );        % Set some parameters for the algorithm
    
    
END_ACADO;           % Always end with "END_ACADO".
                     % This will generate a file problemname_ACADO.m. 
                     % Run this file to get your results. You can
                     % run the file problemname_ACADO.m as many
                     % times as you want without having to compile again.



out = turtlebot_energy_RUN();               % Run the test. The name of the RUN file
                                            % is problemname_RUN, so in
                                            % this case
                                            % turtlebot_RUN
                                            
%Get the states and control signals                                            
t_states = out.STATES(:,1);
x_out = out.STATES(:,2);

t_controls = out.CONTROLS(:,1);
first_control_out = out.CONTROLS(:,2);

%% Optimal control using ACADO, minimum time problem
clear;

BEGIN_ACADO;                                % Always start with "BEGIN_ACADO". 
    
    acadoSet('problemname', 'turtlebot_time');     % Set your problemname. If you 
                                                   % skip this, all files will
                                                   % be named "myAcadoProblem"
    
    
    DifferentialState       x;              % The differential states, add turtlebot states
        
    Control                 ...;            % The control signals, add
    Parameter               T;              %The end time is now a parameter
    
    % Differential Equation
    f = acado.DifferentialEquation(0,T);      % Set the differential equation object
    
    f.add(dot(x) == ...);  % Write down your equations. You can add 
                           % multiple ODE's and DAE's with f.add()  

    

    
    % Optimal Control Problem
    tStart = 0.0;                           % Set up the Optimal Control Problem (OCP)
    intervals = 40;                         % intervals upto T s  
    ocp = acado.OCP(tStart, T, intervals);          
                                            
    ocp.minimizeMayerTerm( T );               % Minimize a Mayer term
    
    ocp.subjectTo( f );                     % Your OCP is always subject to your 
                                            % differential equation                                  
    ocp.subjectTo( 'AT_START', x == ... );  % Initial conditions

    ocp.subjectTo( 'AT_END', x == ... );    % Terminal conditions
    
    ocp.subjectTo(... <= x <= ...);         % You can also add constraints
                                            % on the states and control signals 
    % Optimization Algorithm
    algo = acado.OptimizationAlgorithm(ocp); % Set up the optimization algorithm
    
    algo.set('KKT_TOLERANCE', 1e-5 );        % Set some parameters for the algorithm
    
    
END_ACADO;           % Always end with "END_ACADO".
                     % This will generate a file problemname_ACADO.m. 
                     % Run this file to get your results. You can
                     % run the file problemname_ACADO.m as many
                     % times as you want without having to compile again.



out = turtlebot_time_RUN();                 % Run the test. The name of the RUN file
                                            % is problemname_RUN, so in
                                            % this case
                                            % turtlebot_RUN
                                            
%Get the states and control signals                                            
t_states = out.STATES(:,1)*out.PARAMETERS(1,2); %Need to scale with T
x_out = out.STATES(:,2);

t_controls = out.CONTROLS(:,1)*out.PARAMETERS(1,2); %Need to scale with T
first_control_out = out.CONTROLS(:,2);

