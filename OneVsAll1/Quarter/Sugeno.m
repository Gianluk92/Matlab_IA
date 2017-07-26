clearvars -except sensor1 sensor2 sensor3 data needUseS1 needUseS2 needUseS3 target
mean_features = zeros(10,1);
mean_cluster = zeros(12,1);

targetIn = [ones(24,1) zeros(24,1);
            zeros(72,1) ones(72,1)];


targetTest = [ones(16,1) zeros(16,1);
              zeros(48,1) ones(48,1)];  
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
            if(needUseS1(features,k) == 1)
                x = [sensor1(1:24,k);sensor1(41:64,k);sensor1(81:104,k);sensor1(121:144,k)];
                Xinp = [Xinp x];
                t = [sensor1(25:40,k);sensor1(65:80,k);sensor1(105:120,k);sensor1(145:160,k)];
                Xtest = [Xtest t];
            end
        end
        
        warning off
        opt = [1.5,50,1e-6,0];
        sugenoFis = genfis3(Xinp,targetIn,'sugeno',cluster,opt);
        out = evalfis(Xtest,sugenoFis);
        warning on
        
        [tp,fp,distance,accuracy] = EvalFis_roc(out',targetTest);
     
        hold on
      
        if(distance>=0)
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
accu_mat = cell2mat(accu);


for i=1:1:10
    color = [0.1*i,0.01*i,1];
    %plot(max(accu_mat(i,:)),'o','Color',color);
    mean_features(i) = max(accu_mat(i,:));
end
for i=1:1:12
    mean_cluster(i)= max(accu_mat(:,i));
end
plot([1,0],[1,0],'-');

% features 9 cluster 4 sensore 1