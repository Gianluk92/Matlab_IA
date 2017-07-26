function[error] = fitnesfunctionS3(ga_val,sensor3,target)

input = [];
for i=1:1:12
    if(ga_val(i) == 1)
        input = [input sensor3(:,i)];
    end
end

hiddenLayer = 10;
net = patternnet(hiddenLayer);
net.divideParam.trainRatio = 60/100;
net.divideParam.testRatio = 20/100;
net.divideParam.valRatio = 20/100;
[net,~] = train(net,input',target');
outputs = net(input');
%error = gsubtract(target,output);
%performace = perform(net,target,output);
error = confusion(target',outputs);
%figure, plotconfusion(target,output)
