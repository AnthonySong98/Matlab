R=0.0275;
r=0.0490;
Year=0:1:10;
Year1=0:1:5;
Year2=6:1:10;
Ak=@(k)((1+k*R)*100);
A=[0:1:10;zeros(1,length(0:1:10))];
%A balance ����һ���Ի���Ϣ
A(2:2,1:6)=Ak(Year1);
A(2:2,7:11)=Ak(Year2-5)+A(2,6)-100;

%BA balance ���»�Ϣ�����ڻ���
BA=[0:1:10;zeros(1,length(0:1:10))];
for i=1:1:10
    BA(2,i)=100*(1+r)^(i-1);
end
BA(2,11)=0;
BA_tax=BA(2,10);
BA_tax_rate=(BA_tax-100)/100;

%BB balance
BB=[0:1:10;zeros(1,length(0:1:10))];
for i=1:1:10
    BB(2,i)=100*(1+r/12)^(12*(i-1));
end
BB(2,11)=0;
BB_tax=BB(2,10);
BB_tax_rate=(BB_tax-100)/100;

%BC balance �ȶ��
BC=[0:1:10;zeros(2,length(0:1:10))];
BC(2,:)=[10:-1:0];
for i=2:1:11
    BC(3,i)=100*(r*(1-(i-2)/10)+1/10);
end
BC_tax=sum(BC(3,:));
BC_tax_rate=(BC_tax-100)/100;

%BD balance �ȶϢ
BD=[0:1:10;zeros(1,length(0:1:10))];
m=(r*100*(1+r)^10)/((1+r)^10-1);
BD(2,1)=100;
for i=2:1:11
    BD(2,i)=(100-m/r)*(1+r)^(i-1)+m/r;
end
BD_tax=m*10;
BD_tax_rate=(BD_tax-100)/100;

%BE balance ���ʱ��һ���Կ۳���Ϣ��������ÿ�»�����
BE=[0:1:10;zeros(1,length(0:1:10))];
BE(2,1)=100-100*r;
for i=2:2:11
    BE(2,i)=10;
end
BE_tax=sum(BE(2,:));
BE_tax_rate=r;
