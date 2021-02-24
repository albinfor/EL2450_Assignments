close all;
clear all;
clc;

%% Define parameters
R = 1;
L = 1;
h = 1;
x_ref = 1;
y_ref = 1;
theta_ref = pi/4;

%% Plot theta for K = [0.5, 1.0, 1.5, 2.0]
for K=0.5:0.5:2.0
    K_Psi = K;
    K_w = K;
    sim('task_9_model');
    data_theta_error = ans.theta_error;
    data_d0 = ans.d0;

    t = data_d0.time;
    theta_error = data_theta_error.signals.values;
    d0 = data_d0.signals.values;
    
    figure(1), hold on
    stairs(t,theta_error,'Linewidth',1)
    xlabel('Time $t$','Interpreter','latex')
    ylabel('Directional error $\theta^R-\theta[k]$','Interpreter','latex')
    legend
    grid on
    
    figure(2), hold on
    stairs(t,d0,'Linewidth',1)
    xlabel('Time $t$','Interpreter','latex')
    ylabel('Positional error $d_0[k]$','Interpreter','latex')
    grid on
end

figure(1)
legend('$K_\Psi=K_w=0.5$','$$K_\Psi=K_w=1.0$','$$K_\Psi=K_w=1.5$','$$K_\Psi=K_w=2.0$','Interpreter','latex')

figure(2)
legend('$K_\Psi=K_w=0.5$','$$K_\Psi=K_w=1.0$','$$K_\Psi=K_w=1.5$','$$K_\Psi=K_w=2.0$','Interpreter','latex')



