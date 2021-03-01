T = readtable('task_17_excel_touched_csv.csv');

x = T.x;
y = T.y;
timestamp = T.timestamp;
theta = T.theta;

figure()
plot(x,y)
axis([-1.5 1.5 -1.5 1.5])
axis square
title('Path of Robot following path')
xlabel('x')
ylabel('y')
grid on
%% For task 17
figure()

StateNumber = T.StateNumber;
plot(StateNumber);
axis([0 5084 -0.5 1.5])
grid on
title('Discrete State progression')
xlabel('Time steps')
ylabel('state')


figure()
subplot(4,1,1)
plot(x)
axis([0 5300 -1.5 1.5])
title('x position')
subplot(4,1,2)
plot(y)
axis([0 5300 -1.5 1.5])
title('y position')
subplot(4,1,3)
plot(theta)
axis([0 5300 -200 200])
title('\theta orientation')
subplot(4,1,4)
plot(StateNumber)
axis([0 5300 -0.1 1.1])
title('Discrete State progression')
