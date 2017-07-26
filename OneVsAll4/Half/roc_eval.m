function [tp,fp,distance] = roc_eval(out,target,threshold)
% compute the max distance between the bisector and the point [0,1]
tp = 0;
fp = 0;
n_p = 0;
n_n = 0;
for i=1:1:length(target)
   [val_m,j] = max(out(:,i));
   val = target(i);
   if(val)
       n_p = n_p+1;
       if(val == j && val_m>=threshold)
            tp = tp+1;
       end
   else
       n_n = n_n+1;
       if(i>11 && val~=j && val_m>=threshold)
            fp = fp+1;
       end
   end
end
if(n_p+n_n ~= length(target))
    fprintf('Errore');
    return;
end
tp = tp/n_p; % this is a point on the x axes
fp = fp/n_n; % this is a point on the y axes
% we have to compute the distance between the point and the line. 
% The line equation is y-x = 0 -> |x-y|/sqrt(2)
distance = abs(tp-fp)/sqrt(2);