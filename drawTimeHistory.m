function drawTimeHistory(conf)
%UNTITLED 이 함수의 요약 설명 위치
%   자세한 설명 위치
filename = 'timeHistory.dat';
fullPath = strcat(conf.resultDir,filename);
% fid = fopen(fullPath,'r');
fid = fopen(fullPath,'r');
data = fread(fid,[2,inf],'double');
fclose(fid);

figure(12)
plot(data(1,100:(end-500)),'--o')
title('p time series')
figure(13)
plot(data(2,100:(end-500)),'--o')
title('u time series')

end

