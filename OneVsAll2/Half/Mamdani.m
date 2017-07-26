clearvars -except sensor1 sensor2 sensor3 data needUseS1 needUseS2 needUseS3 target
mean_features = zeros(10,1);
mean_cluster = zeros(12,1);

targetIn = [zeros(12,1) ones(12,1);
            ones(12,1) zeros(12,1);
            zeros(24,1) ones(24,1)];


targetTest = [zeros(8,1) ones(8,1);
              ones(8,1) zeros(8,1);
              zeros(16,1) ones(16,1)];  
% I use the 60% of the total input for training the Fuzzy system and the
% rest for testing the system. For evaluate the accuracy we use the easiest
% formula -> n: number of correct result tot:total value to test
% n/tot
%for h=1:1:100
accu_gen = 0;
accu = cell(10,13);
clu = 0;
for cluster=1:1:12
    accuracy = 0;
    for features=1:1:10
        Xinp = [];
        Xtest = [];
        for k=1:1:12
            if(needUseS1(features,k) == 1)
                x = [sensor1(1:12,k);sensor1(21:32,k);sensor1(41:52,k);sensor1(61:72,k)];
                Xinp = [Xinp x];
                t = [sensor1(13:20,k);sensor1(33:40,k);sensor1(53:60,k);sensor1(73:80,k)];
                Xtest = [Xtest t];
            end
        end
        
        warning off
        opt = [1.5,50,1e-6,0];
        mamdaniFis = genfis3(Xinp,targetIn,'mamdani',cluster,opt);
        out = evalfis(Xtest,mamdaniFis);
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

%% sensore scelto per la rete mamdani è il sensore 1 con 6 cluster features 9