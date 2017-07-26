
function [accuracy,n_p,n_n] = EvalFis_roc(out,target)
    index = [];
    n_p = 0;
    n_n = 0;
    for i=1:1:length(out)
        [~,index{i}] = max(out(i,:));
        [~,index_t{i}] = max(target(i,:));
    end
    
    for i=1:1:length(out)
            if(index{i} == index_t{i})
                n_p=n_p+1;
            else
                n_n=n_n+1;
            end
    end
    accuracy = n_p/length(out);
    
end