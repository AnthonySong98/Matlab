%in this section I will analyse the population change in Shanghai
%data source: https://www.google.com.hk/imgres?imgurl=https%3A%2F%2Fimage.slidesharecdn.com%2Fdemographicsofacapitalcity-131223225203-phpapp01%2F95%2Fdelhi-demographics-of-a-capital-city-3-638.jpg%3Fcb%3D1389582553&imgrefurl=https%3A%2F%2Fwww.slideshare.net%2Fvarshajoshi95%2Fdelhi-demographics-of-a-capital-city%2F24-19611971_THE_AGE_OF_DELHI&docid=CAlc5ys70KaucM&tbnid=BglLDZ9Pbia9bM%3A&vet=10ahUKEwi8iYfLnovaAhUCE7wKHXZHCLMQMwg-KAEwAQ..i&w=638&h=359&bih=730&biw=1440&q=new%20delhi%20population%20change&ved=0ahUKEwi8iYfLnovaAhUCE7wKHXZHCLMQMwg-KAEwAQ&iact=mrc&uact=8

Year=1901:10:1991;
Population=[40.5819,41.3851,48.8452,63.6246,91.7939,174.4072,265.8612,406.5698,622.0406,942.0644];
PopulationLast=[1404.6035,2040.9832]
Population_R=[3.93,5.31,7.24,9.64,12.87,17.07,23.19,31.44,38.56,...
    50.16,62.95,76.0]

%Malthus拟合参数
p=polyfit(Year,log(Population),1);
r=p(1,1);
x0=exp(p(1,2));
Year_1=1901:5:2011;
Population_1=x0*exp(r*Year_1);
figure(1);
plot(Year,Population,'+',Year_1,Population_1,'r',[2000,2005],PopulationLast,'*');
hold on
xlabel("year");
ylabel("population");
title("Population Model of Malthus")


%Logistic拟合参数
P = @(p,t)(p(2).*p(3)./((p(2)-p(3)).*exp(-p(1).*t)+p(3)));
%LOGISTIC: MATLAB function file that takes
%time t, growth rate r (p(1)),
%carrying capacity K (p(2)),
%and initial population P0 (p(3)), and returns
%the population at time t.

Population_2=1901:5:2011; 
lowerbound = zeros(1,3);
options = optimset('MaxFunEvals',100000);
p0=[0.007,5000,0];
q=lsqcurvefit(P,p0,Year,Population,lowerbound,[],options)
%q =
%q=lsqcurvefit(P,p0,Year,Population)
 %  -3.1143  490.5006    3.9296
 Prediction=@(t)(q(2).*q(3)./((q(2)-q(3)).*exp(-q(1).*(t))+q(3)));
% plot([0:1:2000],Prediction([0:1:2000]));
figure(2)
 plot(Year,Population,'+')
 plot(Year,Population,'+',Year_1,Prediction(Year_1),'r',[2000,2005],PopulationLast,'*');
hold on
xlabel("year");
ylabel("population");
title("Population Model of Logistic")
%plot(Year,Population,'+',Year_1,q,'r');
