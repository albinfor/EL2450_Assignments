close all;
clear all;
clc;

%% Define parameters
R = 1;
L = 1;
h = 1;

%% Plot theta for K = [0.5, 1.0, 1.5, 2.0]
figure, hold on
for K=0.5:0.5:2
    sim('task_6');
    data = ans;

    t = data.theta.time;
    theta = data.theta.signals.values;
    plot(t,theta)
end
ylim([0 2.0])
xlabel('Time $t$','Interpreter','latex')
ylabel('Theta $\theta$','Interpreter','latex')
legend('$K_\Psi=0.5$','$K_\Psi=1.0$','$K_\Psi=1.5$','$K_\Psi=2.0$','Interpreter','latex')






