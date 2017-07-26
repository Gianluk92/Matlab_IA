%% sugeno vs mamdani Sensore:2 features:6 cluster:5
close all;
targetIn = [zeros(8,1) ones(8,1)
            ones(8,1) zeros(8,1);
            zeros(16,1) ones(16,1)];

targetTest = [zeros(2,1) ones(2,1);
              ones(2,1) zeros(2,1);
              zeros(4,1) ones(4,1)];   
Xinp = [];
Xtest = [];
for k=1:1:12
    if(needUseS2(6,k) == 1)
        x = [sensor2(1:8,k);sensor2(11:18,k);sensor2(21:28,k);sensor2(31:38,k)];
        Xinp = [Xinp x];
        t = [sensor2(9:10,k);sensor2(19:20,k);sensor2(29:30,k);sensor2(39:40,k)];
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

%% mamdani vs sugeno Sensore:2 features:10 cluster:11
targetIn = [zeros(8,1) ones(8,1)
            ones(8,1) zeros(8,1);
            zeros(16,1) ones(16,1)];

targetTest = [zeros(2,1) ones(2,1);
              ones(2,1) zeros(2,1);
              zeros(4,1) ones(4,1)];    
          
for k=1:1:12
    if(needUseS2(10,k) == 1)
        x = [sensor2(1:8,k);sensor2(11:18,k);sensor2(21:28,k);sensor2(31:38,k)];
        Xinp = [Xinp x];
        t = [sensor2(9:10,k);sensor2(19:20,k);sensor2(29:30,k);sensor2(39:40,k)];
        Xtest = [Xtest t];
    end
end

 opt = [1.5,50,1e-6,0];
 SugenoFis = genfis3(Xinp,targetIn,'sugeno',11,opt);
 MamdaniFis = genfis3(Xinp,targetIn,'mamdani',11,opt);
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
