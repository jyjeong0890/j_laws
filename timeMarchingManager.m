function p = timeMarchingManager( config )

[x,y] = gridGen(config);
if(config.inputPulseType==4)
	currentTime = config.initialT0;
else
	currentTime = 0;
end
nStep=0;
nWritingFile = 0;
[ux,uy,p] = imposeIC(x,y, config);
if10 = implicitFilter(10,config.filterAlpha);
writingCoord(x,y,config);
h = waitbar(0,'Start marching','Name','Progress RK4 time marching...');
totalStep = ceil((config.timeLimit-currentTime)/config.deltaT);
writingData(p,nStep,currentTime,config);
if(config.dim==2)
	try
		RK4_module = RK4_2D_Marching(x,y,config,if10);		
		disp('Start RK4 time marching')
		tLoop = tic;
		while(currentTime<config.timeLimit)
			[ux,uy,p,currentTime] = RK4_module.march(ux,uy,p,currentTime);
			nStep=nStep+1;
			infoMsg = sprintf('%d/%d step is complete (t=%f)',nStep,totalStep,currentTime);
			waitbar(nStep/totalStep,h,infoMsg)
			if(mod(nStep,config.writingInterval)==0)
				writingData(p,nStep,currentTime,config);
				nWritingFile = nWritingFile+1;
			end
		end
		tElapsed1 = toc(tLoop);
		delete(h)
		fprintf('RK Iteration takes %f (s).\n',tElapsed1);
	catch ME
		delete(h)
		disp('Error catching')
		rethrow(ME)
	end
else
	RK4_module = RK4_1D_Marching(x,config,if10);
	disp('Start RK4 time marching')
	tLoop = tic;
	while(currentTime<config.timeLimit)
		[ux,p,currentTime] = RK4_module.march(ux,p,currentTime);
		nStep=nStep+1;
		infoMsg = sprintf('%d/%d step is complete (t=%f)',nStep,totalStep,currentTime);
		waitbar(nStep/totalStep,h,infoMsg)
		if(mod(nStep,config.writingInterval)==0)
			writingData(p,nStep,currentTime,config);
			nWritingFile = nWritingFile+1;
		end
	end
	tElapsed1 = toc(tLoop);
	delete(h)
	fprintf('RK Iteration takes %f (s).\n',tElapsed1);
end
fprintf('Total step=%d, Writing file=%d\n',nStep, nWritingFile);
listFilename = dir(config.resultDir);
numFile = length(listFilename);
fprintf('File list of the result directory\n')
for n=1:numFile
	tempName = listFilename(n).name;
	fprintf('%d: %s\n',n,tempName);
end
fprintf('End RK4 time marching\n');
end