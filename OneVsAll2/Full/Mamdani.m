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
for cluster=1:1:12
    accuracy = 0;
    for features=1:1:10
        Xinp = [];
        Xtest = [];
        for k=1:1:12
            if(needUseS1(features,k) == 1)
                x = [sensor1(1:8,k);sensor1(11:18,k);sensor1(21:28,k);sensor1(31:38,k)];
                Xinp = [Xinp x];
                t = [sensor1(9:10,k);sensor1(19:20,k);sensor1(29:30,k);sensor1(39:40,k)];
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
        accu{features,cluster} = [accu{features,cluster}; accuracy,distance;];
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

%% sensore scelto per la rete mamdani è il sensore 1 con 11 cluster features 10