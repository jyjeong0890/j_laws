function [isOK] = writingData(p,nstep,currentTime,conf)
%  	Solution field p at currentTime is stored

% filename_u = sprintf('velocity_%06d.dat',nstep);
filename_p = sprintf('pressure_%06d.dat',nstep);
% filePath_u = strcat(conf.resultDir,filename_u);
filePath_p = strcat(conf.resultDir,filename_p);
% uid = fopen(filePath_u,'w');
pid = fopen(filePath_p,'w');
% fwrite(uid,time,'double');
fwrite(pid,currentTime,'double');
% fwrite(uid,u_,'double');
fwrite(pid,p,'double');
% isOK1 = fclose(uid);
isOK = fclose(pid);
% isOK = isOK1+isOK2;

end

