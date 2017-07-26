%%
close all;
Xinp = [];
Xtest = [];
targetIn = [ones(24,1) zeros(24,1);
            zeros(72,1) ones(72,1)];


targetTest = [ones(16,1) zeros(16,1);
              zeros(48,1) ones(48,1)];    
          
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
    plot(fp,tp,'go');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'yo');
end

accuracy
distance
tp
fp
plot([1,0],[1,0],'-')

%% 
targetIn = [ones(24,1) zeros(24,1);
            zeros(72,1) ones(72,1)];


targetTest = [ones(16,1) zeros(16,1);
              zeros(48,1) ones(48,1)];   

          
for k=1:1:12
    if(needUseS1(5,k) == 1)
        x = [sensor1(1:24,k);sensor1(41:64,k);sensor1(81:104,k);sensor1(121:144,k)];
        Xinp = [Xinp x];
        t = [sensor1(25:40,k);sensor1(65:80,k);sensor1(105:120,k);sensor1(145:160,k)];
        Xtest = [Xtest t];
    end
end
 opt = [1.5,50,1e-6,0];
 SugenoFis = genfis3(Xinp,targetIn,'sugeno',10,opt);
 MamdaniFis = genfis3(Xinp,targetIn,'mamdani',10,opt);
 out_S = evalfis(Xtest,SugenoFis);
 out_M = evalfis(Xtest,MamdaniFis);
 
[tp,fp,distance,accuracy] = EvalFis_roc(out_S',targetTest);

hold on;

if(distance>0)
    plot(fp,tp,'b*');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'r*');
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
