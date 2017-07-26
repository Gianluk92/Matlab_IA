
function [accuracy] = EvalFis_roc(out,target,plot_on)
index = [];
    n_p = 0;
    n_n = 0;
    for i=1:1:length(out)
        [~,index{i}] = max(out(i,:));
        [~,index_t{i}] = max(target(i,:));
    end
    index;
    index_t;
    ok_a1 =0;
    for i=1:1:length(out)
            if(index{i} == index_t{i})
                ok_a1=ok_a1+1;
            end
    end
    accuracy = ok_a1/length(out);
end