Data=xlsread("data_Q2.xlsx","1","B16:I23");
Data=Data'+Data;
[n,m]=size(Data);
trace=zeros(1,n);
profits=xlsread("data_Q2.xlsx","1","I2:I9")';
suggest_time=xlsread("data_Q2.xlsx","1","H2:H9")';
end_time=xlsread("data_Q2.xlsx","1","G2:G9")';
start_time=xlsread("data_Q2.xlsx","1","F2:F9")';



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
    
    d_path(times,n+1)=min_sum_path;%n+1�б���·�ϻ�������ʱ��
    
    temp=perm(index:index,1:nn);
    for q=1:length(temp)
        d_path(times,q)=temp(q);
    end
    
    %����ʣ��ʱ��
    travel=8;
    for q=1:length(temp)
        if(q==1)
            travel=travel+suggest_time(temp(q));
        else
            travel=travel+Data(temp(q-1),temp(q))/60+suggest_time(temp(q));
        end
    end
    
    d_path(times,n+3)=12-travel;%n+3�б���ʣ��ʱ��
    
    %�����Ƿ�Ա��Ÿ�
    travel=8;resbool=1;
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
    
    d_path(times,n+4)=resbool;%n+4�б����Ƿ��Ա��Ÿ���0��ʾ�ԣ�1��ʾû�г�
    
    
    
    
end
    





