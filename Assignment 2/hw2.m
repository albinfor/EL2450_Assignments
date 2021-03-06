clc;
close all;
t = ry1.time;
y = ry1.signals;
y1 = y(1).values;
y2 = y(2).values;
y3 = y(3).values;

figure(1)
plot(t,y1,t,y2,t,y3)
grid on
title('EDF at 6ms execution time')

t = ry.time;
y = ry.signals;
y1 = y.values(:,1);
y2 = y.values(:,2);
y3 = y.values(:,3);

figure(2)
plot(t,y1,t,y2,t,y3)
grid on
title('scheduling at 6ms execution time')

%%
C = 10;
T = [20, 29, 35];
U = sum(C./T)

%%
clc;
close all;
t = ry1.time;
y = ry1.signals;
y1 = y(1).values;
y2 = y(2).values;
y3 = y(3).values;

figure(1)
plot(t,y1,t,y2,t,y3)
grid on
title('EDF at 10ms execution time')

t = ry.time;
y = ry.signals;
y1 = y.values(:,1);
y2 = y.values(:,2);
y3 = y.values(:,3);

figure(2)
plot(t,y1,t,y2,t,y3)
grid on
title('scheduling at 10ms execution time')

%%

for time_delay = 0:0.005:0.04
sim('inv_pend_delay');
t = ry1.time;
y = ry1.signals.values;
plot(t,y)
hold on
end
title('Stability vs time delay')
legendCell = strcat('delay=',string(num2cell(0:0.005:0.04)));
legend(legendCell, 'location', 'southeast');
grid on