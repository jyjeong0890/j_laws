function [tempData_cut, tempData_time] = visualizeData_2D(conf, nthFile)
%   visualize 2D solution field (contourf, pcolor,surfl,...)
%	nthFile is the order of the target file in the directory.

listFilename = dir(conf.resultDir);
numFile = length(listFilename);
lenX = conf.innerPtX+conf.bufferPt*2;
lenY = conf.innerPtY+conf.bufferPt*2;
halfLineY = (conf.innerPtY+1)/2;

for n=1:numFile
	tempName = listFilename(n).name;
	isCoordinateX = strcmp(tempName,'coordinateX.dat');
	isCoordinateY = strcmp(tempName,'coordinateY.dat');
	if(isCoordinateX)
		idx_coordX = n;
	elseif(isCoordinateY)
		idx_coordY = n;
	end
end
if(numFile==-1)
	disp('ERR: coordinate.dat is not found')
end

fullName_coordX = strcat(conf.resultDir,listFilename(idx_coordX).name);
fid = fopen(fullName_coordX,'r');
x = fread(fid,[lenY, lenX],'double');
fclose(fid);
fullName_coordY = strcat(conf.resultDir,listFilename(idx_coordY).name);
fid = fopen(fullName_coordY,'r');
y = fread(fid,[lenY, lenX],'double');
fclose(fid);

if(conf.gridType==1)
	ptXA = conf.bufferPt+1;
	ptXB = lenX - conf.bufferPt;
	ptYA = conf.bufferPt+1;
	ptYB = lenY - conf.bufferPt;
elseif(conf.gridType==4)
	ptXA = conf.bufferPt+1;
	ptXB = lenX;
	ptYA = conf.bufferPt+1;
	ptYB = lenY;
elseif(conf.gridType==2)
	ptXA = 1;
	ptXB = lenX;
	ptYA = 1;
	ptYB = lenY;
end

x_cut = x(ptYA:ptYB,ptXA:ptXB);
y_cut = y(ptYA:ptYB,ptXA:ptXB);

% load result
tempName = listFilename(nthFile).name;
tempFullFilePath = strcat(conf.resultDir,tempName);
isPressure = strncmp(tempName,'pressure_',9);

if(isPressure==1)
	fid = fopen(tempFullFilePath,'r');
	tempData_time = fread(fid,1,'double');
	tempData_raw = fread(fid,[lenY, lenX],'double');
	fclose(fid);
	tempData_cut = tempData_raw(ptYA:ptYB,ptXA:ptXB);
	titleString = sprintf('t=%f',tempData_time);
	
	figure(1)
	pcolor(x_cut,y_cut,tempData_cut)
	shading interp
	lighting gouraud
	colormap gray
    colorbar
    title(titleString)
    h = gca;
    h.CLim = [-0.25; 0.25];
    g = gcf;
    g.Position = [100 200 700 525];
    grid on
    figure(2)
    contourf(x_cut,y_cut,tempData_cut,45)
    grid on
    title(titleString)
    colorbar
    h = gca;
    h.CLim = [-0.25; 0.25];
    figure(3)
    surfl(x_cut,y_cut,tempData_cut)
    shading interp
    lighting gouraud
	colormap gray
	figure(4)
	plot(x_cut(halfLineY,:),tempData_cut(halfLineY,:),'--o')
	h = gca;
    h.CLim = [-0.25; 0.25];
	centerLineP = y(halfLineY,1);
	titleString = sprintf('centerLine(y=%f), t=%f',centerLineP,tempData_time);
	title(titleString)
	grid on

else
	disp(tempName)
	disp('is not pressure result file.')
end


end

