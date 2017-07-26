% ga that choose the best feature to pass to the fuzzy network
target = [ones(20,1) zeros(20,3);
          zeros(20,1) ones(20,1) zeros(20,2);
          zeros(20,2) ones(20,1) zeros(20,1);
          zeros(20,3) ones(20,1)];
      
fitnessFcn1 = @(x)fitnesfunctionS1(x,sensor1,target);
fitnessFcn2 = @(x)fitnesfunctionS2(x,sensor2,target);
fitnessFcn3 = @(x)fitnesfunctionS3(x,sensor3,target);

nvar = 12;

options = gaoptimset;
options = gaoptimset(options,'SelectionFcn',@selectionroulette, 'CrossoverFcn', @crossovertwopoint,...
'MutationFcn', @mutationgaussian,'Display','off',... %'PlotFcns', {@gaplotbestf @gaplotbestindiv},...
'Generations', 150, 'PopulationSize',80, 'PopulationType','doubleVector','UseParallel',true);

needUseS1=zeros(10,12);
valS1=zeros(10,1);
needUseS2=zeros(10,12);
valS2=zeros(10,1);
needUseS3=zeros(10,12);
valS3=zeros(10,1);
%  
for i=1:1:10
    [needUseS1(i,:),valS1(i,1)] = ga(fitnessFcn1,nvar,...
       [ones(1,nvar);-ones(1,nvar)],[3;-3],[],[],zeros(1,nvar),ones(1,nvar),[],1:1:nvar,options);
   
   [needUseS2(i,:),valS2(i,1)] = ga(fitnessFcn2,nvar,...
       [ones(1,nvar);-ones(1,nvar)],[3;-3],[],[],zeros(1,nvar),ones(1,nvar),[],1:1:nvar,options);
   
   [needUseS3(i,:),valS3(i,1)] = ga(fitnessFcn3,nvar,...
       [ones(1,nvar);-ones(1,nvar)],[3;-3],[],[],zeros(1,nvar),ones(1,nvar),[],1:1:nvar,options);
end

save('workspace');