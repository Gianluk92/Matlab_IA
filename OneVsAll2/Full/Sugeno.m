clearvars -except sensor1 sensor2 sensor3 data needUseS1 needUseS2 needUseS3 target
mean_features = zeros(10,1);
mean_cluster = zeros(12,1);

targetIn = [zeros(8,1) ones(8,1)
            ones(8,1) zeros(8,1);
            zeros(16,1) ones(16,1)];

targetTest = [zeros(2,1) ones(2,1);
              ones(2,1) zeros(2,1);
              zeros(4,1) ones(4,1)]; 
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
            if(needUseS3(features,k) == 1)
                x = [sensor3(1:8,k);sensor3(11:18,k);sensor3(21:28,k);sensor3(31:38,k)];
                Xinp = [Xinp x];
                t = [sensor3(9:10,k);sensor3(19:20,k);sensor3(29:30,k);sensor3(39:40,k)];
                Xtest = [Xtest t];
            end
        end
        
        warning off
        %opt = [1.5,50,1e-6,0];
        sugenoFis = genfis3(Xinp,targetIn,'sugeno',cluster);
        out = evalfis(Xtest,sugenoFis);
        warning on
        
        [tp,fp,distance,accuracy] = EvalFis_roc(out',targetTest);
     
        hold on
        if(distance>0)
            plot(fp,tp,'bo');
        else
            accuracy = 1-accuracy;
            tp = 1-tp;
            fp = 1-fp;
            plot(fp,tp,'ro');
        end
        %accu{features} = [accu{features}; accuracy distance tp fp];
        accu{features,cluster} = [accu{features,cluster}; accuracy];
    end
end
plot([1,0],[1,0],'-');
accu_mat = cell2mat(accu);


%% Sensore scelto per la rete sugeno è il 1 con 10 cluster e features 4