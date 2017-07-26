% in this case we have 20 patients for each activity so we have a total of
% 80 samples divided in 20 samples for each activity.
clc;
clear all;
global data sensor1 sensor2 sensor3;
load('data\data.mat');

data_2 = cell(4,20);

for i=1:1:4
    for j=1:1:10
        data_2{i,j*2-1} = data{i,j}(1:1000,:);
        data_2{i,j*2} = data{i,j}(1001:2000,:);
    end
end


media = cell(4,1);
mini  = cell(4,1);
mass  = cell(4,1);
acorr = cell(4,1);
ff   = cell(4,1);
modu  = cell(4,1);
fas   = cell(4,1);
scart = cell(4,1);
roms  = cell(4,1);
mediana = cell(4,1);
inviluppom_p = cell(4,1);
inviluppom_n = cell(4,1);
dev_sta = cell(4,1);
varianz = cell(4,1);

for i=1:1:20
    for j=1:1:4
        [inv_p,inv_n] = envelope(data_2{j,i}(:,1:3)); 
        invm_p = mean(inv_p);
        invm_n = mean(inv_n);
        inviluppom_p{j} = [inviluppom_p{j};invm_p];
        inviluppom_n{j} = [inviluppom_n{j};invm_n];
        a2 = median(data_2{j,i}(:,1:3));
        mediana{j} = [mediana{j}; a2];
        a1 = rms(data_2{j,i}(:,1:3));
        roms{j} = [roms{j}; a1];
        m1 = mean(data_2{j,i}(:,1:3));
        media{j}=[media{j}; m1];        % media
        m2 = cummax(data_2{j,i}(:,1:3));
        mass{j} = [mass{j};mean(m2)];         % massimo 
        a = sqrt(var(data_2{j,i}(:,1:3)));
        scart{j} = [scart{j};a];        % scarto quadratico medio
        m3 = min(data_2{j,i}(:,1:3));
        mini{j} = [mini{j};m3];         % minimo
        tran = fft(data_2{j,i}(:,1:3));
        ff_med = mean(tran);
        ff{j} = [ff{j};ff_med];           % media trasformate fourier
        ass_tras = abs(tran);
        s_pha = unwrap(angle(tran));
        media_pha = mean(s_pha);
        fas{j} = [fas{j};media_pha];    % media delle fasi
        media_mod = mean(ass_tras);
        modu{j} = [modu{j};media_mod];  % media dei moduli
        m4 = std(data_2{j,i}(:,1:3));
        dev_sta{j} = [dev_sta{j}; m4];
        m5 = var(data_2{j,i}(:,1:3));
        varianz{j} = [varianz{j};m5]; 
        c1 = xcorr(data_2{j,i}(:,1)); 
        c2 = xcorr(data_2{j,i}(:,2));
        c3 = xcorr(data_2{j,i}(:,3));
        c = [c1 c2 c3];
        cm = max(c);  
        acorr{j}=[acorr{j};cm];         % autocorrelazione tra il valore e il max
    end
end
sensor1 = [];
sensor2 = [];
sensor3 = [];

for i=1:1:4
    sensor1 = [sensor1; mass{i}(:,1) mini{i}(:,1) media{i}(:,1) modu{i}(:,1) fas{i}(:,1) scart{i}(:,1) acorr{i}(:,1) mediana{i}(:,1) inviluppom_p{i}(:,1) inviluppom_n{i}(:,1) dev_sta{i}(:,1) varianz{i}(:,1)];
    sensor2 = [sensor2; mass{i}(:,2) mini{i}(:,2) media{i}(:,2) modu{i}(:,2) fas{i}(:,2) scart{i}(:,2) acorr{i}(:,2) mediana{i}(:,2) inviluppom_p{i}(:,2) inviluppom_n{i}(:,2) dev_sta{i}(:,2) varianz{i}(:,2)];
    sensor3 = [sensor3; mass{i}(:,3) mini{i}(:,3) media{i}(:,3) modu{i}(:,3) fas{i}(:,3) scart{i}(:,3) acorr{i}(:,3) mediana{i}(:,3) inviluppom_p{i}(:,3) inviluppom_n{i}(:,3) dev_sta{i}(:,3) varianz{i}(:,3)];
end

sensor1 = [ScaleAndCenter(sensor1(:,1)) ScaleAndCenter(sensor1(:,2))...
ScaleAndCenter(sensor1(:,3)) ScaleAndCenter(sensor1(:,4))...
ScaleAndCenter(sensor1(:,5)) ScaleAndCenter(sensor1(:,6))...
ScaleAndCenter(sensor1(:,7)) ScaleAndCenter(sensor1(:,8)) ...
ScaleAndCenter(sensor1(:,9)) ScaleAndCenter(sensor1(:,10))...
ScaleAndCenter(sensor1(:,11)) ScaleAndCenter(sensor1(:,12))];

sensor2 = [ScaleAndCenter(sensor2(:,1)) ScaleAndCenter(sensor2(:,2))...
ScaleAndCenter(sensor2(:,3)) ScaleAndCenter(sensor2(:,4))...
ScaleAndCenter(sensor2(:,5)) ScaleAndCenter(sensor2(:,6))...
ScaleAndCenter(sensor2(:,7)) ScaleAndCenter(sensor2(:,8)) ...
ScaleAndCenter(sensor2(:,9)) ScaleAndCenter(sensor2(:,10))...
ScaleAndCenter(sensor2(:,11)) ScaleAndCenter(sensor2(:,12))];

sensor3 = [ScaleAndCenter(sensor3(:,1)) ScaleAndCenter(sensor3(:,2))...
ScaleAndCenter(sensor3(:,3)) ScaleAndCenter(sensor3(:,4))...
ScaleAndCenter(sensor3(:,5)) ScaleAndCenter(sensor3(:,6))...
ScaleAndCenter(sensor3(:,7)) ScaleAndCenter(sensor3(:,8)) ...
ScaleAndCenter(sensor3(:,9)) ScaleAndCenter(sensor3(:,10))...
ScaleAndCenter(sensor3(:,11)) ScaleAndCenter(sensor3(:,12))];

clearvars -except sensor1 sensor2 sensor3 data
