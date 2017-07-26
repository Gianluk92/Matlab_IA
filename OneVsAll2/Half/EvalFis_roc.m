function [tpr,fpr,distance,accuracy] = EvalFis_roc(out,target)
% compute the max distance between the bisector and the point [0,1]
tp = 0;
tn = 0;
fp = 0;
n_p = 0;
n_n = 0;
for i=1:1:length(target)
   [val_m,j] = max(out(:,i));
   val = target(i);
   if(val)
       n_p = n_p+1;
       if(val == j)
            tp = tp+1;
       end
   else
       n_n = n_n+1;
       if(val~=j-2)
            fp = fp+1;
       end
       if(val==j-2)
           tn = tn+1;
       end
   end
end

if(n_p+n_n ~= length(target))
    fprintf('Errore');
    return;
end
tpr = tp/n_p; % this is a point on the x axes
fpr = fp/n_n; % this is a point on the y axes
accuracy = (tp+tn)/(n_p+n_n);
% we have to compute the distance between the point and the line. 
% The line equation is y-x = 0 -> |x-y|/sqrt(2)
distance = ((tp/n_p)-(fp/n_n))/(sqrt(2));