%% sugeno vs mamdani Sensore:2 features:5 cluster:8
close all;
targetIn = [ones(6,1) zeros(6,1);
            zeros(18,1) ones(18,1)];


targetTest = [ones(4,1) zeros(4,1);
              zeros(12,1) ones(12,1)];  
          
for k=1:1:12
    if(needUseS2(5,k) == 1)
        x = [sensor2(1:6,k);sensor2(11:16,k);sensor2(21:26,k);sensor2(31:36,k)];
        Xinp = [Xinp x];
        t = [sensor2(7:10,k);sensor2(17:20,k);sensor2(27:30,k);sensor2(37:40,k)];
        Xtest = [Xtest t];
    end
end
 opt = [1.5,50,1e-6,0];
 SugenoFis = genfis3(Xinp,targetIn,'sugeno',8,opt);
 MamdaniFis = genfis3(Xinp,targetIn,'mamdani',8,opt);
 out_S = evalfis(Xtest,SugenoFis);
 out_M = evalfis(Xtest,MamdaniFis);
 
[tp,fp,distance,accuracy] = EvalFis_roc(out_S',targetTest);

hold on;

if(distance>0)
    plot(fp,tp,'ro');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'bo');
end

accuracy

[tp,fp,distance,accuracy] = EvalFis_roc(out_M',targetTest);
 
if(distance>0)
    plot(fp,tp,'y*');
else
    accuracy = 1-accuracy;
    tp = 1-tp;
    fp = 1-fp;
    plot(fp,tp,'r*');
end
accuracy
plot([1,0],[1,0],'-')

%% mamdani vs sugeno Sensore:1 features:5 cluster:5
targetIn = [ones(6,1) zeros(6,1);
            zeros(18,1) ones(18,1)];


targetTest = [ones(4,1) zeros(4,1);
              zeros(12,1) ones(12,1)];  
          
for k=1:1:12
    if(needUseS1(5,k) == 1)
        x = [sensor1(1:6,k);sensor1(11:16,k);sensor1(21:26,k);sensor1(31:36,k)];
        Xinp = [Xinp x];
        t = [sensor1(7:10,k);sensor1(17:20,k);sensor1(27:30,k);sensor1(37:40,k)];
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
plot([1,0],[1,0],'-')
