function [ x ] = gridStretcher( bufferPoint, innerPoint, expRatio, deltaX, stretchingType )
%UNTITLED2 이 함수의 요약 설명 위치
%   stretchingType=1 -> each side is stretched
%	stretchingType=2 -> one side is stretched (x=0)

% innerPoint: 0~N
% bufferPt: -BP~-1, N+1~N+BP
if(stretchingType==1)
	numPt = bufferPoint*2+innerPoint;
	x = zeros(numPt,1);
	ptA = bufferPoint+1;
	ptB = bufferPoint+innerPoint+1;
	for n=1:bufferPoint
		idx = bufferPoint-n+1;
		bufferProtrude = expRatio*deltaX*(expRatio^idx-1)/(expRatio-1);
		x(n) = -1*bufferProtrude;
	end
	idx = 0;
	for n=ptA:(bufferPoint+innerPoint)
		x(n) = idx*deltaX;
		idx = idx+1;
	end
	tempDeltaX = deltaX;
	for n=ptB:numPt
		tempDeltaX = tempDeltaX*expRatio;
		x(n) = x(n-1)+tempDeltaX;
	end
elseif(stretchingType==2)
	numPt = bufferPoint+innerPoint;
	x = zeros(numPt,1);
	ptA = bufferPoint+1;
	for n=1:bufferPoint
		idx = bufferPoint-n+1;
		bufferProtrude = expRatio*deltaX*(expRatio^idx-1)/(expRatio-1);
		x(n) = -1*bufferProtrude;
	end
	idx = 0;
	for n=ptA:(bufferPoint+innerPoint)
		x(n) = idx*deltaX;
		idx = idx+1;
	end
else
	disp('[ERR-gridStretcher] stretchingType is out of range')
end


end