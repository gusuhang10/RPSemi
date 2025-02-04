function [W,F,FCell]=updateWandF(W,F,S,lumbda,beta,T,C,N,ListLabled,YLabeledData,endpos,labels) 
    flag=0;
    t=1;
    iniW=W;
    iniF=F;
    while flag~=1 && t<=T        
        oldW=W;
        oldF=F;
        for c=1:C
            FF=F;
            FF(:,c)=[];
            maxFF=max(FF,[],2);
            ipos=ListLabled(find(YLabeledData==labels(c)));
            aa=S(ipos,:);
            bb=lumbda*maxFF(ipos);
            W(ipos,:,c)=bsxfun(@minus,aa,bb);  
            %W(ipos,:,c)=S(ipos,:)-repmat(lumbda*maxFF(ipos),1,N);
            F(:,c)=sum(W(ipos,:,c),1)'-diag(W(:,:,c))-beta*maxFF;            
        end              
        F=normalize(F);
        for c=1:C
            if c==1
                W(ListLabled(1:endpos(c)),ListLabled(1:endpos(c)),c)=iniW(ListLabled(1:endpos(c)),ListLabled(1:endpos(c)),c);
            else
                W(ListLabled(endpos(c)-endpos(c-1)+1:endpos(c)),ListLabled(endpos(c)-endpos(c-1)+1:endpos(c)),c)=iniW(ListLabled(endpos(c)-endpos(c-1)+1:endpos(c)),ListLabled(endpos(c)-endpos(c-1)+1:endpos(c)),c);
            end
        end        
        F(ListLabled,YLabeledData)=iniF(ListLabled,YLabeledData);        
        %ÅÐ¶ÏÊÇ·ñÊÕÁ²
        diffnorm=norm(F-oldF);
        if diffnorm<0.0001
            flag=1;
        end
        FCell{t}=F;
        t=t+1;
    end
end