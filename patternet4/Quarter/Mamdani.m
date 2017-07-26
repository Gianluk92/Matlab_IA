clearvars -except sensor1 sensor2 sensor3 data needUseS1 needUseS2 needUseS3 target
mean_features = zeros(10,1);
mean_cluster = zeros(12,1);

target = [ones(40,1) zeros(40,3);
          zeros(40,1) ones(40,1) zeros(40,2);
          zeros(40,2) ones(40,1) zeros(40,1);
          zeros(40,3) ones(40,1)];

targetIn = [ones(8,1) zeros(8,3);
          zeros(8,1) ones(8,1) zeros(8,2);
          zeros(8,2) ones(8,1) zeros(8,1);
          zeros(8,3) ones(8,1)];


targetTest = [ones(2,1) zeros(2,3);
              zeros(2,1) ones(2,1) zeros(2,2);
              zeros(2,2) ones(2,1) zeros(2,1);
              zeros(2,3) ones(2,1)];  
% I use the 60% of the total input for training the Fuzzy system and the
% rest for testing the system. For evaluate the accuracy we use the easiest
% formula -> n: number of correct result tot:total value to test
% n/tot
%for h=1:1:100
accu_gen = 0;
accu = cell(10,13);
clu = 0;
close all
for cluster=1:1:12
    accuracy = 0;
    for features=1:1:10
        Xinp = [];
        Xtest = [];
        for k=1:1:12
            if(needUseS2(features,k) == 1)
                Xinp = [Xinp sensor2(:,k)];
            end
        end
        
        warning off
        opt = [1.5,50,1e-6,0];
        mamdaniFis = genfis3(Xinp,target,'mamdani',cluster,opt);
        out = evalfis(Xinp,mamdaniFis);
        warning on
        [C,CM,IND,PER] = confusion(target',out');
        plotconfusion(target',out');
        %[accuracy,n_p,n_n] = EvalFis_roc(out,target);
     
        accu{features,cluster} = [accu{features,cluster}; 1-C];
    end
end
accu_mat = cell2mat(accu);

%%
Xinp = [];
for k=1:1:12
    if(needUseS1(8,k) == 1)
        Xinp = [Xinp sensor1(:,k)];
    end
end
opt = [NaN,NaN,NaN,0];
sugenoFis = genfis3(Xinp,target,'sugeno',11,opt);
out = evalfis(Xinp,sugenoFis);
[C,CM,IND,PER] = confusion(target',out');
C
plotconfusion(target',out');

figure

mamdaniFis = genfis3(Xinp,target,'mamdani',11,opt);
out = evalfis(Xinp,mamdaniFis);
[C,CM,IND,PER] = confusion(target',out');
C
plotconfusion(target',out');

%% Sensore scelto per la rete sugeno è il 1 con 7 cluster e features 10