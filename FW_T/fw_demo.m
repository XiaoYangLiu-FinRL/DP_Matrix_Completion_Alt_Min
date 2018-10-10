addpath('./FW_T/func');
addpath('./FW_T/PROPACK');
warning off;

data = 'movielens'; %�����ļ���

delta = 1e-3;
rho = .75;  %������

fprintf('**************************************************************\n')
fprintf(strcat(data, ' experiment', ' has started! \n'))
path = strcat('.\data\',data,'.mat');
load(path);  %��ȡ�����ļ�

D=input;

[m n] = size(D); %����data�����ļ���ľ����С
fprintf('data has been loaded: m = %d, n = %d; \n', m,n);
frameSize(1)=m;
frameSize(2)=n;


%����rho��ȷ������Omega
if rho == 1
    
    fprintf('RPCA with full obseravation; \n');
    obs = D; Omega = ones(m,n);
    
else
    
    fprintf('RPCA with partial obseravation: ');
    Omega = rand(m,n)<=rho; % support of observation
    obs = Omega.*D; % measurements are made
    fprintf('observations are generated; \n');
    
end

%�������ڿ�����������ı���
obs = obs/norm(obs, 'fro'); %��һ��
lambda_1 = delta*rho; 
lambda_2 = delta*sqrt(rho)/sqrt(max(m,n)); %���򻯲���

showvideo = 1;%�Ƿ���ʾͼ��

par.M = obs; 
par.lambda_1 = lambda_1; par.lambda_2 =lambda_2;
par.iter = 1000; 
par.epsilon = 10^-3; % stopping criterion
par.Omega = Omega;
par.showvideo = true; 
par.framesize = frameSize;

fprintf('**************************************************************\n')
fprintf('Let us try FW-T method! \n');
fprintf('**************************************************************\n')

output_fw = FW_T(par); % main function

% obtain the objective value returned from FW-T
L = output_fw.L; S = output_fw.S;
p = output_fw.plot; iter = output_fw.iter-1;

t=[1:iter];
semilogy(t,p,'*-');
% 20*log10(p(iter));
legend('FW\_T');

%title('Matrix:300X300,rank:50');
xlabel('Iterations');
ylabel('RMSE');
saveas(gcf,'figure.jpg');
