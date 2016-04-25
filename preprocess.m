function [Xp] = preprocess(X)
% Generate zero mean and unit variance data
% Argument
% Input
%      X: original data
%      Xp: preprocess data
d = size(X,2); Xp = zeros(size(X));
    
    for i=1:d
       
        Xp(:,i)=(X(:,i)-mean(X(:,i)))/std(X(:,i));
    
    end