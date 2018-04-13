options=odeset('reltol',10e-12,'abstol',10e-15)
[t,x]=ode45('shier',[0 15],[25 2],options);  
%figure
%plot(t,x(:,1),'-',t,x(:,2),'*')
%figure
%plot(x(:,1),x(:,2))
X=x(1:100,1);
Y=x(1:100,2);
A=[log(Y),Y,log(X),X];
b=ones(size(X));
A\b
