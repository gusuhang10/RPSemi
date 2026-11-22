clear,clc
load phoneme;
data=phoneme;
X=data(:,1:end-1);
X=normalize(X);
Y=data(:,end);
[N,d]=size(X);
labels=unique(Y);
C=length(labels);
T=300;%number of iterations
r=0.03;%proportion of labeled samples
dis=pdist2(X,X);
sigma=0.09;
S=calculateS(dis,sigma);
paraeta=min(mean(S));%lumbda=sum(sum(S))/N/10000;
paragamma=min(mean(S));
[ListLabeled,YLabeledData,unListLabeled,YUnlabeledData]=labelY(Y,r,C,labels);
[W,F,endpos]=iniWandF(N,ListLabeled,YLabeledData,C,S,labels);
initime=cputime;
[W,F]=updateWandF(W,F,S,paraeta,paragamma,T,C,N,ListLabeled,YLabeledData,endpos,labels);
time=cputime-initime;
for c=1:C
    dispre(:,c)=S*F(:,c);
end
[~,preYwhole]=max(dispre,[],2);
preY=preYwhole(unListLabeled,:);
ACC=sum(YUnlabeledData==preY)/length(preY);