function S=calculateS(dis,sigma)
n=size(dis,1);
S=dis.^2;
S=S./(2*(sigma.^2));
S=exp(-S);
S=S-eye(n);
%S=S./sum(S,2);  
end