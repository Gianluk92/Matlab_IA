load('data\data.mat')
a1p1s1 = ScaleAndCenter(data{1,1}(:,1));
a1p2s1 = ScaleAndCenter(data{1,2}(:,1));
 a1p3s1 = ScaleAndCenter(data{1,3}(:,1));
 a1p4s1 = ScaleAndCenter(data{1,4}(:,1));
 a1p5s1 = ScaleAndCenter(data{1,5}(:,1));
 a1p6s1 = ScaleAndCenter(data{1,6}(:,1));
% a3p1s1 = ScaleAndCenter(data{3,1}(:,1));
hold on;
plot(a1p1s1)
plot(a1p2s1)
plot(a1p4s1)
plot(a1p3s1)
plot(a1p5s1)
plot(a1p6s1)


% plot(sensor1(1:10,7))
% plot(sensor1(11:20,7))
% plot(sensor1(21:30,7))
% plot(sensor1(31:40,7))