data = 'movielens'; %�����ļ���
path = strcat('.\data\',data,'.mat');
load(path);  
D = input;   %��ȡ�����ļ�
[MM,NN] = size(D); %����data�����ļ���ľ����С

rho=.75;

Omega = rand(MM,NN)<=rho; % support of observation
D_omega = Omega.*D; % measurements are made
D_omega1= D_omega';
Omega1 =Omega';
% PP=rand(1);
% P=PP(1,1);
RR=rank(D);
T=10;


I = maxl2norm(D,Omega);
delta=2.2251e-308;
temp=sqrt(2*log(2/(delta)))/(2*log(1/(delta)));
sigma = 2*I*sqrt(2*log(2/(delta)))/(2*log(1/(delta)));

for t=1:T  %ѭ������
    if t==1
        U = randi([0,5],MM,RR);
%         temp=D_omega.*P;
%         [U,S1,V1]=svds(temp,RR);
    end
    for j=1:NN %�ֱ���V��ÿһ��
        y=D_omega(:,j);        
        for i=1:RR
            x1(:,i)=Omega(:,j).*U(:,i);%����������K�ĵ�j�и�U0��Ӧ�е�ÿ��Ԫ�����
        end
        v(:,j)=pinv(x1)*y; %��v�ĵ�j��
    end
    V=v';
    for j=1:MM %�ֱ���U��ÿһ��
        y=D_omega1(:,j);
        for i=1:RR
            x2(:,i)=Omega1(:,j).*V(:,i);
        end
        u(:,j)=pinv(x2)*y; %��A'�ĵ�j��
    end
    U=u';V=V';
    U=U+normrnd(0,sigma^2);
    M0=U*V;  
    p(t)=norm(D-M0,'fro')/norm(D(:));
    p2(t)=rmse(D,M0);        
end


% 20*log10(p(10))
q=[1:T];
pic=semilogy(q,p2);
