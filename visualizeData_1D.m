function [tempData_cut, tempData_time] = visualizeData_1D(conf,nthFile)
%   visualize 2D solution field
%	nthFile is the order of the target file in the directory.

listFilename = dir(conf.resultDir);
numFile = length(listFilename);
lenX = conf.innerPtX+conf.bufferPt*2;

for n=1:numFile
	tempName = listFilename(n).name;
	isCoordinateX = strcmp(tempName,'coordinateX.dat');
	if(isCoordinateX)
		idx_coordX = n;
	end
end
if(numFile==-1)
	disp('ERR: coordinate.dat is not found')
end

fullName_coordX = strcat(conf.resultDir,listFilename(idx_coordX).name);
fid = fopen(fullName_coordX,'r');
x = fread(fid,lenX,'double');
fclose(fid);

if(conf.gridType==1)
	ptA = conf.bufferPt+1;
	ptB = lenX - conf.bufferPt;
elseif(conf.gridType==4)
	ptA = conf.bufferPt+1;
	ptB = lenX;
elseif(conf.gridType==2)
	ptA = 1;
	ptB = lenX;
end
x_cut = x(ptA:ptB);

%% load result
tempName = listFilename(nthFile).name;
tempFullFilePath = strcat(conf.resultDir,tempName);
isPressure = strncmp(tempName,'pressure_',9);
labelName = tempName(1);

if(isPressure==1)
	fid = fopen(tempFullFilePath,'r');
	tempData_time = fread(fid,1,'double');
	tempData_raw = fread(fid,lenX,'double');
	fprintf('t=%f\n',tempData_time);
	fclose(fid);
	tempData_cut = tempData_raw(ptA:ptB);
	titleString = sprintf('p, t=%f',tempData_time);
	
	figure(1)
	h1 = plot(x_cut,tempData_cut,'--o');
    h = gca;
    h.YLim = [0, 0.5];
    title(titleString)
    g = gcf;
    g.Position = [100 200 700 525];
	grid on
	xlabel('X')
else
	disp(tempName)
	disp('is not pressure result file.')
end


end

