function  final_result=perm_comb(x,y)
m=1:x;
n=[];
temp=combnk(m,y);
for k=1:size(temp,1)
    n=[n;perms(temp(k,:))];
end
aa=repmat(m(:),1,y);
final_result=[aa;n];
end


a = 1:1:4;b = 4;
A = nchoosek(a,b);
B = arrayfun(@(k)perms(A(k,:)),(1:size(A,1))','UniformOutput',false);
FullB = cell2mat(B);