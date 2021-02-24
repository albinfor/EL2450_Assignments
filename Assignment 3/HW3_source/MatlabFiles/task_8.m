close all;
clear all;
clc;

%% Define parameters
R = 1;
L = 1;
h = 1;
theta = pi/6;

%% Plot theta for K = [0.5, 1.0, 1.5, 2.0]
figure, hold on
for K=0.5:0.5:2
    sim('task_8_model');
    data = ans;

    t = data.d0.time;
    d0 = data.d0.signals.values;
    plot(t,d0)
end
% ylim([0 2.0])
xlabel('Time $t$','Interpreter','latex')
ylabel('Error $d_0$','Interpreter','latex')
legend('$K_w=0.5$','$K_w=1.0$','$K_w=1.5$','$K_w=2.0$','Interpreter','latex')
