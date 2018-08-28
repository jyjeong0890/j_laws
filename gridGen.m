function [ x,y ] = gridGen( config )

% gridType=1 -> grid stretching on each side
% gridType=4 -> grid stretching on the inflow side x=0
gridType = config.gridType;
if(config.dim==2)
	if(gridType==1)
		x_ = gridStretcher(config.bufferPt,config.innerPtX,config.expRatio,config.deltaX,1);
		y_ = gridStretcher(config.bufferPt,config.innerPtY,config.expRatio,config.deltaY,1);
	elseif(gridType==2)
		ptXB = (config.innerPtX-1)*config.deltaX;
		x_ = transpose(0:config.deltaX:ptXB);
		ptYB = (config.innerPtY-1)*config.deltaY;
		y_ = transpose(0:config.deltaY:ptYB);
	elseif(gridType==4)
		x_ = gridStretcher(config.bufferPt,config.innerPtX,config.expRatio,config.deltaX,2);
		y_ = gridStretcher(config.bufferPt,config.innerPtY,config.expRatio,config.deltaY,2);
	else
		fprintf('[ERR-gridGen] gridType is out of range\n');
	end

	[x,y] = meshgrid(x_,y_);
else
	if(gridType==1)
		x = gridStretcher(config.bufferPt,config.innerPtX,config.expRatio,config.deltaX,1);
	elseif(gridType==2)
		ptXB = (config.innerPtX-1)*config.deltaX;
		x = transpose(0:config.deltaX:ptXB);
	elseif(gridType==4)
		x = gridStretcher(config.bufferPt,config.innerPtX,config.expRatio,config.deltaX,2);
	else
		fprintf('[ERR-gridGen] gridType is out of range\n');
	end
	y=0;
end

end

