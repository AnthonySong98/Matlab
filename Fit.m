year=(1997:1:2009);
house_price=[767,895,995,1117,1261,1437,1640,1957,2244,2489,2801,3096,3500];
GDP=[3540 3783 3916 4239 4922 5560 6399 7842 9116 10879 13475 16737 18745];
income=[5156 5138 6526 7434 8475 9688 10703 11384 12343 13630 15558 18472 19820];
%第一问
f1=polyfit(year,house_price,2);
house_price_predict=polyval(f1,year);
year_predict=(2010:1:2018);
plot(year,house_price,'*',year,house_price_predict,'-',year_predict,polyval(f1,year_predict),'o');
xlabel('年份(y)','FontSize',16)
ylabel('平均房价（元／平米）','FontSize',16);
title('预测2010-2018年该城市的平均房价')
res1=polyval(f1,year_predict);
%第二问
f2=polyfit(log(GDP),house_price,2);
polyval(f2,log(GDP));
plot(log(GDP),(polyval(f2,log(GDP))),'o',log(GDP),house_price,'*');
xlabel('ln(GDP)','FontSize',16);
ylabel('平均房价（元／平米）','FontSize',16);
title('该城市人均GDP与平均房价的关系');
legend('拟合','实际');
res2=f2;
%第三问
Y=house_price';
X=[ones(length(Y),1),GDP',income'];
[b,bint,r,rint,stats]=regress(Y,X);
res3=b;