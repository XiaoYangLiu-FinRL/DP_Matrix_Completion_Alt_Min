data = 'movielens'; %�����ļ���
path = strcat('.\data\',data,'.mat');
load(path);  
D = input;   %��ȡ�����ļ�
[MM,NN] = size(D); %����data�����ļ���ľ����С

rho=.75

Omega = rand(MM,NN)<=rho; % support of observation
Omega1 = Omega';
D_omega = Omega.*D; % measurements are made
D_omega1 = D_omega';
PP=rand(1);
P=PP(1,1);
RR=rank(D);

for t=1:400  %ѭ������
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
    VV=V';
    for j=1:MM %�ֱ���A'��ÿһ��
        y=D_omega1(:,j);
        for i=1:RR
            x2(:,i)=Omega1(:,j).*VV(:,i);
        end
        U(:,j)=x2\y; %��A'�ĵ�j��
    end
    UU=U';VV=VV';
    M0=UU*VV;  
    p2(1,t)=rmse(D,M0);        
end


% subplot(1,2,1)
% imshow(uint8(f01));title('original')
% subplot(1,2,2)
%imshow(uint8(M0))
% 20*log10(p(10))
%t=[1:10];
% semilogy(t,p);
%semilogy(e,p2);
%title('Matrix:200*200,rank:30');
%xlabel('Iterations');
%ylabel('RSE in log-scale');