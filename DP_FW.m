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