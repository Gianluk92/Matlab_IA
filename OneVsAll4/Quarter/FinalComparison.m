%% sensore 1 feature 2 cluster 5
close all;
Xinp = [];
Xtest = [];
targetIn = [zeros(72,1) ones(72,1);
            ones(24,1) zeros(24,1);
            ];


targetTest = [zeros(48,1) ones(48,1);
              ones(16,1) zeros(16,1);
              ]; 
          
for k=1:1:12
    if(needUseS1(2,k) == 1)
        x = [sensor1(1:24,k);sensor1(41:64,k);sensor1(81:104,k);sensor1(121:144,k)];
        Xinp = [Xinp x];
        t = [sensor1(25:40,k);sensor1(65:80,k);sensor1(105:120,k);sensor1(145:160,k)];
        Xtest = [Xtest t];
    end
end

 opt = [1.5,50,1e-6,0];
 SugenoFis = genfis3(Xinp,targetIn,'sugeno',5,opt);
 MamdaniFis = genfis3(Xinp,targetIn,'mamdani',5,opt);
 out_S = evalfis(Xtest,SugenoFis);
 out_M = evalfis(Xtest,MamdaniFis);
 
[tp,fp,distance,accuracy] = EvalFis_roc(out_S',targetTest);

hold on;

if(distance>0)
    plot(fp,tp,'bo');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'ro');
end

accuracy
distance
tp
fp

[tp,fp,distance,accuracy] = EvalFis_roc(out_M',targetTest);
 
if(distance>0)
    plot(fp,tp,'g*');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'y*');
end
accuracy
distance
tp
fp
plot([1,0],[1,0],'-')

%% sensore 3 features 4 cluster 6
targetIn = [zeros(72,1) ones(72,1);
            ones(24,1) zeros(24,1);
            ];


targetTest = [zeros(48,1) ones(48,1);
              ones(16,1) zeros(16,1);
              ];    

Xinp =[];
Xtest = [];
for k=1:1:12
    if(needUseS3(4,k) == 1)
        x = [sensor3(1:24,k);sensor3(41:64,k);sensor3(81:104,k);sensor3(121:144,k)];
        Xinp = [Xinp x];
        t = [sensor3(25:40,k);sensor3(65:80,k);sensor3(105:120,k);sensor3(145:160,k)];
        Xtest = [Xtest t];
    end
end
 opt = [1.5,50,1e-6,0];
 SugenoFis = genfis3(Xinp,targetIn,'sugeno',6,opt);
 MamdaniFis = genfis3(Xinp,targetIn,'mamdani',6,opt);
 out_S = evalfis(Xtest,SugenoFis);
 out_M = evalfis(Xtest,MamdaniFis);
 
[tp,fp,distance,accuracy] = EvalFis_roc(out_S',targetTest);

hold on;

if(distance>0)
    plot(fp,tp,'bo');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'ro');
end

accuracy
distance
tp
fp

[tp,fp,distance,accuracy] = EvalFis_roc(out_M',targetTest);
 
if(distance>0)
    plot(fp,tp,'g*');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'y*');
end
accuracy
distance
tp
fp
plot([1,0],[1,0],'-')
