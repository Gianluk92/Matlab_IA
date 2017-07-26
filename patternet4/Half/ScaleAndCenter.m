 %% function that produce the datas normalizzation

function [ v1 ] = ScaleAndCenter( vector )
% scaleAndCenter 
    n=length(vector);
    center=mean(vector);
    v=std(vector);
    v1=(vector-center)/v;
end