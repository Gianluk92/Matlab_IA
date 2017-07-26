function[sensitivity] = fitnesfunctionS1(ga_val,other_v,target)
% here we can't use the confusion matrix, because the number of target
% value aren't balanced. For this reason is better use the ROC evaluation.
% Thanks to this is possible compute the sensitivity.
sensor1 = other_v;
input = [];
for i=1:1:12
    if(ga_val(i) == 1)
        input = [input sensor1(:,i)];
    end
end

hiddenLayer = 12;
net = patternnet(hiddenLayer);
net.divideParam.trainRatio = 70/100;
net.divideParam.testRatio = 20/100;
net.divideParam.valRatio = 10/100;
[net,~] = train(net,input',target');
outputs = net(input');
[~,~,distance]=roc_eval(outputs,target,0.5);
% The genetic algorithm try to minimize the fitnes function for this reason
% we consider the negation of the distance 
sensitivity = -distance;
