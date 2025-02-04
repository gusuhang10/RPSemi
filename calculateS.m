function S=calculateS(dis,mu,sigma)
n=size(dis,1);
S=dis.^2;
S=S./(mu*(sigma.^2));
S=exp(-S);
S=S-eye(n);
%S=S./sum(S,2);  
end