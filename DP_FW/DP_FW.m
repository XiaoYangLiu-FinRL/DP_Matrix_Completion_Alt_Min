%%%�ο�����DP_MC_Revisited��
%%%Algorithm 1 Private Frank-Wolfe algorithm
%%%��ΪGlobal Component��Local Update
addpath('./FW_T/func');
addpath('./FW_T/PROPACK');
warning off;

data = 'movielens'; %�����ļ���

rho = .75;  %������

path = strcat('.\data\',data,'.mat');
load(path);  %��ȡ�����ļ�

D = input;

[nu ni] = size(D); %����data�����ļ���ľ����С
fprintf('data has been loaded: m = %d, n = %d; \n', m,n);

%initialization

delta = 10^(-100);
epsilon = 2*log(1/delta);
T = 10000;
L = maxl2norm(D,rho,nu);
beta = 10^(-2);
k = 2*rank(D);

p=zeros(1,T)

sigma = (L^2*sqrt(64*T*log(1/delta)))/epsilon;
v = zeros(1*n);
lamda = 0;


for t=1:T
    (v,lamda)=global(D,rho,L,T,delta,epsilon,beta,sigma,v,lamda,k)
end
