filename = 'H:\GitHub\DP_Matrix_Completion_Alt_Min\data\input.xlsx'; %�����ļ���

P(:,:)=xlsread(filename,1,'B2:OK6041');%��ȡ�����ļ�

[m n] = size(P); %����data�����ļ���ľ����С
fprintf('data has been loaded: m = %d, n = %d; \n', m,n);


