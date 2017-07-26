 %% function that produce the datas normalizzation

function [ v1 ] = ScaleAndCenter( vector )
% scaleAndCenter 
    n=length(vector);
    center=mean(vector);
    v=sqrt(var(vector));
    v1=(vector-center*ones(n,1))/v;
end