function [F,D] = FC_sSVD(T,K,lambda1,lambda2)

%Input : 
%T tensor to reduce
%K number of factor
S = size(T);
if length(S)==3
M = reshape(T,S(1),S(2)*S(3));
else
M = T; 
end

%method 7 : sSVD
param.modeParam=2;
param.K=K; % learns a dictionary with K elements
param.lambda=lambda1;
param.verbose=false;
param.iter=1000; %Number of iteration
param.modeD=1; %Sparse dictionary
param.gamma1=lambda2;

[D] = mexTrainDL(M',param);
Ul=mexLasso(M',D,param);

%Solve scaling uncertainty
Dscaling = diag(sqrt(sum(D.^2)));
F  = full((Ul')*Dscaling);
D = full(D*diag(diag(Dscaling).^(-1)));


end