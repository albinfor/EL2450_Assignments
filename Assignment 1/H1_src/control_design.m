%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hybrid and Embedded control systems
% Homework 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

init_tanks;
g = 9.82;
Tau = 1/alpha1*sqrt(2*tank_h10/g);
k_tank = 60*beta*Tau;
gamma_tank = alpha1^2/alpha2^2;
uss = alpha2/beta*sqrt(2*g*tank_init_h2)*100/15; % steady state input
yss = 40; % steady state output

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Continuous Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = tf('s');
uppertank = (k_tank)/(1+Tau*s);
lowertank = (gamma_tank)/(1+gamma_tank*Tau*s);
G = uppertank*lowertank; % Transfer function from input to lower tank level
%uppertank = tf(1); % Transfer function for upper tank
%lowertank = tf(1); % Transfer function for lower tank


% Calculate PID parameters
parameters = [[0.5, 0.7, 0.1];[0.5, 0.7, 0.2];[0.5, 0.8, 0.2]];

param_select = 3;
chi = parameters(param_select,1);
omega0 = parameters(param_select,3);
zeta = parameters(param_select,2);

[K_pid,Ti,Td,N] = polePlacePID(chi,omega0,zeta,Tau,gamma_tank,k_tank);
F = K_pid*(1+(1/(Ti*s))+((Td*N*s)/(s+N)));
sys = F*G/(1+F*G);

opt = stepDataOptions('InputOffset', uss,'StepAmplitude',10);

[y,t] = step(sys,opt);
stepinfo(y-yss,t)

%% Do open loop margins
figure()
for i = 1:3
    param_select = i;
    chi = parameters(param_select,1);
    omega0 = parameters(param_select,3);
    zeta = parameters(param_select,2);

    [K_pid,Ti,Td,N] = polePlacePID(chi,omega0,zeta,Tau,gamma_tank,k_tank);
    F = K_pid*(1+(1/(Ti*s))+((Td*N*s)/(s+N)));

    sys = F*G/(1+F*G);
    hold on
    subplot(2,2,i)
    margin(G*F);
    hold off
end

%% Taking signals from scope and calculating step info
clc;
t = y_digital.time;
y = y_digital.signals(4).values;
y = y-yss;
opt = stepDataOptions('InputOffset', uss,'StepAmplitude',10);
stepinfo(y,t)


%%
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Digital Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts = 4 % Sampling time

% Discretize the continous controller, save it in state space form
sys_d = c2d(F, Ts, 'ZOH');

[A_discretized,B_discretized,C_discretized,D_discretized] = ssdata(sys_d);


A = [0, 0 ; lowertank, 0];
B = [uppertank; 0];
C = [0, 1];
D = 0;
I = eye(2);

system = C*inv(I*s-A)*B;

sys_G = c2d(system, Ts, 'ZOH');

[Phi,Gamma,C_d,D_d, T] = ssdata(sys_G); %???
T
figure()
step(C*(inv(I*s-A))*B)
hold on
step(sys_G)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Discretize the continous state space system, save it in state space form
%[FA, FB, FC, FD] = ssdata(F);
%sys_discrete = ss(FA, FB, FC, FD, Ts);
%Phi = sys_discrete.A;
%Gamma = sys_discrete.B;
%C = sys_discrete.C;
%D = sys_discrete.D;

% Observability and reachability
C = C_d;
D = D_d;
Wc = [];
for i = 1:size(Phi,1)
    Wc = [Wc Phi^(i-1)*Gamma];
end
disp("The rank of the controllability matrix is: "+rank(Wc)+"/"+size(Wc,1))

Wo = [];
for i = 1:size(Phi,1)
    Wo = [Wo; C*Phi^(i-1)];
end
disp("The rank of the observability matrix is: "+rank(Wo)+"/"+size(Wo,1))

% State feedback controller gain
cont_poles = pole(minreal(system));
z = exp(Ts*cont_poles);
%z = [-0.02, -0.02];
% 
L = acker(Phi, Gamma, z);
% observer gain
K = Phi \ C';

% reference gain
lr = 1/(C*(eye(4)-Phi+Gamma*L)^(-1)*Gamma);
% augmented system matrices

%A_a = [Phi-Gamma*L, Gamma*L; zeros(2) Phi-K*C];
%B_a = [Gamma*lr; 0;0]

A_a = [Phi, -Gamma*L; K*C, Phi-K*C-Gamma*L];
B_a = [Gamma*lr; Gamma*lr];






