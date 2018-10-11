data = 'movielens'; %�����ļ���
path = strcat('.\data\',data,'.mat');
load(path);  
D = input;   %��ȡ�����ļ�
[m,n] = size(D); %����data�����ļ���ľ����С
%fprintf('data has been loaded: m = %d, n = %d; \n', m,n);

%��ʼ��global��������Ĳ���
rho = .75;  %������
delta = 10^(-100);
epsilon = 2*log(1/delta);
T = 10000;
L = maxl2norm(D,rho);
beta = 10^(-2);
k = 2*rank(D);

Y=zeros(m,n);

p=zeros(1,T);

sigma = (L^2*sqrt(64*T*log(1/delta)))/epsilon;
v = zeros(1*n);
lamda = 0;

for t=1:T
    W = zeros(n*n);
    lamda1 = lamda + sqrt(sigma*log(n/beta))*n^(1/4);
    for i = 1:m
        [Yi,AN] = Local_Update(i,v,lamda1,T,t,L,D,k) ;
        Y(i,:)=Yi;
        W = W + AN;
    end
    W = W + normrnd(0,sigma^2);
    [V, D] = eig(W);
    lambda = wrev(diag(D));
    V = fliplr(V);
    v=V(:,1);
    lamda=lambda(1,:);
    p(1,t)=rmse(D,Y);
end

q=[1:T];
semilogy(q,p);
