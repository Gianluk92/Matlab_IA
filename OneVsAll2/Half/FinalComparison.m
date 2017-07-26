%%
close all;
targetIn = [zeros(12,1) ones(12,1);
            ones(12,1) zeros(12,1);
            zeros(24,1) ones(24,1)];


targetTest = [zeros(8,1) ones(8,1);
              ones(8,1) zeros(8,1);
              zeros(16,1) ones(16,1)];   
Xinp = [];
Xtest = [];
for k=1:1:12
    if(needUseS1(3,k) == 1)
        x = [sensor1(1:12,k);sensor1(21:32,k);sensor1(41:52,k);sensor1(61:72,k)];
        Xinp = [Xinp x];
        t = [sensor1(13:20,k);sensor1(33:40,k);sensor1(53:60,k);sensor1(73:80,k)];
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
targetIn = [zeros(12,1) ones(12,1);
            ones(12,1) zeros(12,1);
            zeros(24,1) ones(24,1)];


targetTest = [zeros(8,1) ones(8,1);
              ones(8,1) zeros(8,1);
              zeros(16,1) ones(16,1)];    

          
for k=1:1:12
    if(needUseS1(9,k) == 1)
        x = [sensor1(1:12,k);sensor1(21:32,k);sensor1(41:52,k);sensor1(61:72,k)];
        Xinp = [Xinp x];
        t = [sensor1(13:20,k);sensor1(33:40,k);sensor1(53:60,k);sensor1(73:80,k)];
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
