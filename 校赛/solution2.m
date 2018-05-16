Data=xlsread("data_Q2.xlsx","4","B16:I23");
Data=Data'+Data;
[n,m]=size(Data);
trace=zeros(1,n);
profits=xlsread("data_Q2.xlsx","4","I2:I9")';
suggest_time=xlsread("data_Q2.xlsx","4","H2:H9")';
end_time=xlsread("data_Q2.xlsx","4","G2:G9")';
start_time=xlsread("data_Q2.xlsx","4","F2:F9")';
[ndata,text,alldata]=xlsread("data_Q2.xlsx","4","A2:A9");


Data(1,7)=Data(1,7)+10;
Data(7,1)=Data(7,1)+10;

%0-1���߱���di
dim = n;
inputMatrix = dec2bin(0:2^dim-1);
outputMatrix = zeros(2^dim,dim);



for i = 1 : 2^dim
    temp = inputMatrix(i,:);
    outputMatrix(i,:) = str2num(temp(:))';
end

d=outputMatrix;
d_path=zeros(2^n,13);
itertimes=length(d);

for times=2:itertimes
    candidates=find(d(times,:));%ѡ��di=1�ľ���
    nn=length(candidates);%nnΪ��ѡ����ĸ���
    perm=perms(candidates);%permΪ�ɺ�ѡ���㹹�ɵ�����
    
    res_data=zeros(1,length(perm));%res_data����ÿ�����ж�Ӧ������֮��
    iter=length(perm);%��������
    
    %���������
    sum_profit=0;
    for j=1:nn
        sum_profit=sum_profit+profits(perm(1,j));
    end
    
    d_path(times,n+2)=sum_profit;%n+2�б���������
    
        
    
    
    %�������·��
    for i=1:iter
        
        sum_path=0;
        for j=1:nn-1
            sum_path=sum_path+Data(perm(i,j),perm(i,j+1));
        end
        res_data(1,i)=sum_path;
    end
    
    [min_sum_path,index]=min(res_data);
    
    indices=find(res_data==min_sum_path);
    
    d_path(times,n+1)=min_sum_path;%n+1�б���·�ϻ�������ʱ��
    
    for k=1:length(indices)
        index=indices(k);
    
        temp=perm(index:index,1:nn);%����������
        
        %���������ܷ��
        travel=13.5;resbool=1;
        for q=1:length(temp)
            if(q==1)
                if(start_time(temp(q))>travel||travel>end_time(temp(q)))
                    resbool=0;
                end
            else
                travel=travel+Data(temp(q-1),temp(q))/60+suggest_time(temp(q-1));
                if(start_time(temp(q))>travel||travel>end_time(temp(q)))
                    resbool=0;
                end
            end
        end
        
        if(resbool)
            for q=1:length(temp)
                d_path(times,q)=temp(q);
            end
            d_path(times,n+4)=resbool;%n+4�б����Ƿ��Ա��Ÿ���0��ʾ�ԣ�1��ʾû�г�
            break;

        end
        if(k==length(indices)&&resbool==0) 
            d_path(times,n+4)=resbool;
        end
        
        
    end
    %����ʣ��ʱ��
    travel=13.5;
    for q=1:length(temp)
        if(q==1)
            travel=travel+suggest_time(temp(q));
        else
            travel=travel+Data(temp(q-1),temp(q))/60+suggest_time(temp(q));
        end
    end
    
    d_path(times,n+3)=17.5-travel;%n+3�б���ʣ��ʱ��
    
   
    
    
    
    
end

d_path=sortrows(d_path,n+2,'descend');
in=find(d_path(:,n+3)>=0);
for kk=1:length(in)
    if((d_path(in(kk),n+4)==1))
        final_path=d_path(in(kk):in(kk),1:n);
        break;
    end
end


path='';
for ii=1:length(final_path)
    if(final_path(ii)~=0)
        if((ii)==1)
            path=[path,cell2mat(text(final_path(ii)))];
        else
            path=[path,' ',cell2mat(text(final_path(ii)))];
        end
    end
end
path
max_profit=d_path(in(kk),n+2)
traffic_time=d_path(in(kk),n+1)
left_time=d_path(in(kk),n+3)
final_path
    






