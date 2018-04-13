options=odeset('reltol',10e-8,'abstol',10e-12);
[t,x]=ode45('shier',[0 15],[25 2],options);
plot(t,x(:,1),'-',t,x(:,2),'*')
plot(x(:,1),x(:,2))
X=x(:,1);
Y=x(:,2);
A=[log(Y),Y,log(X),X];
C=ones(length(X),1);
b=C\A;