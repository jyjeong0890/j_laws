function [ isOK ] = writingCoord( x,y,conf )

status = exist(conf.resultDir);
if(status==7)
	button = questdlg('There is the folder of the same name. Remove or rename the existing folder.','Warning','Remove','Rename','Remove');
	if(strcmp(button,'Remove'))
		rmdir(conf.resultDir,'s')
    elseif(strcmp(button,'Rename'))
		tempName = strcat(conf.resultDir,'_temp');
		movefile conf.resultDir tempName
		msg = sprintf('Existing folder is changed to %s',tempName);
		disp(msg)
	end
end
mkdir(conf.resultDir);
% conf.writeInfo;
filename_x = sprintf('coordinateX.dat');
filename_y = sprintf('coordinateY.dat');
filename_conf = sprintf('config.mat');
filePath_x = strcat(conf.resultDir,filename_x);
filePath_y = strcat(conf.resultDir,filename_y);
filePath_config = strcat(conf.resultDir,filename_conf);
xid = fopen(filePath_x,'w');
fwrite(xid,x,'double');
isOK = fclose(xid);
yid = fopen(filePath_y,'w');
fwrite(yid,y,'double');
isOK = fclose(yid);
save(filePath_config,'conf');
end