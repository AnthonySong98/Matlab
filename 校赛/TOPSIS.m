Data=xlsread('night-data.xlsx',"night-local-food");
Z=Data;
[Zrow,Zcol]=size(Z);
sum=0;




 
 for i=1:Zrow
     sum=sum+1/(Data(i,2)*Data(i,2));
 end
 for i=1:Zrow
     Z(i,2)=((1/Z(i,2))/sqrt(sum));
 end


for j=2:Zcol
    sum=0;
    for i=1:Zrow
    sum=sum+Data(i,j)*Data(i,j);
    end
    for i=1:Zrow
    Z(i,j)=(Z(i,j)/sqrt(sum));
    end
end

w=[0.05,0.3,0.15,0.15,0.35];
for i=1:Zrow
    Z(i,:)=w.*Z(i,:);
end

for j=1:Zcol
    Z(Zrow+1,j)=max(Z(1:Zrow,j:j));
end
for j=1:Zcol
    Z(Zrow+2,j)=min(Z(1:Zrow,j:j));
end

for i=1:Zrow
    sum1=0;sum2=0;
    for j=1:Zcol
        sum1=sum1+(Z(Zrow+1,j)-Z(i,j))*(Z(Zrow+1,j)-Z(i,j));
        sum2=sum2+(Z(Zrow+2,j)-Z(i,j))*(Z(Zrow+2,j)-Z(i,j));
    end
    Z(i,Zcol+1)=sqrt(sum1);
    Z(i,Zcol+2)=sqrt(sum2);
end

for i=1:Zrow
    Z(i,Zcol+3)=Z(i,Zcol+2)/(Z(i,Zcol+2)+Z(i,Zcol+1));
end


