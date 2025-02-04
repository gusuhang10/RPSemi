function [W,F,endpos]=iniWandF(N,ListLbaled,YLabeledData,C,S,labels)
    %labels should be positive, for example, 1,2,3,4,5,6...
    W=zeros(N,N,C);
    F=zeros(N,C);
    %FF=zeros(N,C);
    for i=1:C        
        a=find(YLabeledData==labels(i));
        endpos(i)=a(end);
    end
    for c=1:C
        if c==1
            W(ListLbaled(1:endpos(c)),ListLbaled(1:endpos(c)),labels(c))=S(ListLbaled(1:endpos(c)),ListLbaled(1:endpos(c)));
            %F(:,c)=sum(W(:,:,c),2);
        else
            W(ListLbaled(endpos(c)-endpos(c-1)+1:endpos(c)),ListLbaled(endpos(c)-endpos(c-1)+1:endpos(c)),labels(c))=S(ListLbaled(endpos(c)-endpos(c-1)+1:endpos(c)),ListLbaled(endpos(c)-endpos(c-1)+1:endpos(c)));
            %F(:,c)=sum(W(:,:,c),2);
        end        
    end
    for i=1:length(ListLbaled)
        %F(ListLbaled(i),YLabeledData(i))=sum(S(:,ListLbaled(i)));
        F(ListLbaled(i),YLabeledData(i))=1;
    end
end