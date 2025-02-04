function [ListLbaeled,YLabeledData,unListLabeled,YUnlabeledData,Numlabeled]=labelY(Y,r,C,labels)%随机均匀选择已知类标
    N=length(Y);
    
    Numlabeled=floor(N*r);
    numC=ceil(Numlabeled/C);
    ListLbaeled=[];
    unListLabeled=[];
    for i=1:C
        a=find(Y==labels(i));
        Randnum=randperm(length(a));
        ListLbaeled=[ListLbaeled;a(Randnum(1:numC))];
        unListLabeled=[unListLabeled;a(Randnum(numC+1:end))];
    end
    YLabeledData=Y(ListLbaeled);
    YUnlabeledData=Y(unListLabeled);
end