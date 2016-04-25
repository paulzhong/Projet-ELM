function [Xtp] = tpreprocess(X,Xt)
% Process test data according to training samples
% Argument
% Input
%      X: original data of training samples
%      Xt: original data of test samples
% Output:
%      Xtp: preprocess data of Xt
d=size(X,2); Xtp=zeros(size(Xt));
  
for i=1:d
        Xtp(:,i)=(Xt(:,i)-mean(X(:,i)))/std(X(:,i));
end