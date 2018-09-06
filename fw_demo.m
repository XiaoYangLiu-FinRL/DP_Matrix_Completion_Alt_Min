data = 'movies.dat'; %数据文件名
% 'movies.dat'
% 'ratings.dat'
% 'users.dat'

delta = 1e-3;
rho = .75;  %采样率

fprintf('**************************************************************\n')
fprintf(strcat(data, ' experiment', ' has started! \n'))
path = strcat('..\data\',data,'.mat');
load(path);  %读取数据文件

[m n] = size(D); %返回data数据文件里的矩阵大小
fprintf('data has been loaded: m = %d, n = %d; \n', m,n);


%根据rho来确定采样Omega
if rho == 1
    
    fprintf('RPCA with full obseravation; \n');
    obs = D; Omega = ones(m,n);
    
else
    
    fprintf('RPCA with partial obseravation: ');
    Omega = rand(m,n)<=rho; % support of observation
    obs = Omega.*D; % measurements are made
    fprintf('observations are generated; \n');
    
end

%生成用于控制噪声级别的变量
obs = obs/norm(obs, 'fro'); %？？？？
lambda_1 = delta*rho; 
lambda_2 = delta*sqrt(rho)/sqrt(max(m,n)); %正则化参数

% display video or not
showvideo = 1;

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
