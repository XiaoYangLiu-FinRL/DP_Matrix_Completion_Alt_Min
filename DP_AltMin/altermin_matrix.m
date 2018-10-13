data = 'movielens'; %�����ļ���
path = strcat('.\data\',data,'.mat');
load(path);  
D = input;   %��ȡ�����ļ�
[MM,NN] = size(D); %����data�����ļ���ľ����С

rho=.75;

Omega = rand(MM,NN)<=rho; % support of observation
D_omega = Omega.*D; % measurements are made
PP=rand(1);
P=PP(1,1);
RR=rank(D);
T=10;

for t=1:T  %ѭ������
    if t==1
        temp=D_omega.*P;
        [U,S1,V1]=svds(temp,RR);
    end
    for j=1:NN %�ֱ���V��ÿһ��
        y=D_omega(:,j);        
        for i=1:RR
            x1(:,i)=Omega(:,j).*U(:,i);%����������K�ĵ�j�и�A0��Ӧ�е�ÿ��Ԫ�����
        end
        V(:,j)=x1\y; %��B�ĵ�j��
    end
    for j=1:MM %�ֱ���U��ÿһ��
        y=D_omega(j,:);
        for i=1:RR
            x2(i,:)=Omega(j,:).*V(i,:);
        end
        U(j,:)=y/x2; %��A'�ĵ�j��
    end
    M0=U*V;  
    p2(1,t)=rmse(D,M0);        
end

q=[1:T];
pic=semilogy(q,p2);
imwrite(pic,picture .fig');
I=imread(picture.fig);
imwrite(picture1.bmp);
imwrite(picture1.png);
