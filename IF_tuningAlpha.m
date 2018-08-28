function [ alpha ] = IF_tuningAlpha( alpha10, orderIF )
%UNTITLED11 이 함수의 요약 설명 위치
%   자세한 설명 위치


testStencilSize = 1000;
% testDataSize = testStencilSize+1;%size of wavenumber vector
halfOrder = floor(orderIF/2);
alpha = zeros(1,5);

wavenumber = 0:(pi/testStencilSize):pi;
increAlpha = 0.0002;
alphaVector = (-0.5+increAlpha):increAlpha:(0.5-increAlpha);
lenAlpha = length(alphaVector);

baseResponse = IF_spectralFunction(wavenumber,orderIF,alpha10);
for n=1:(halfOrder-1)
	tempResponse = IF_spectralFunction(wavenumber,n*2,alphaVector(1));
	sqrtErr = IF_leastSquareErr(baseResponse,tempResponse);
	for k=2:lenAlpha
		tempResponse = IF_spectralFunction(wavenumber,n*2,alphaVector(k));
		tempSqrtErr = IF_leastSquareErr(baseResponse,tempResponse);
		if(tempSqrtErr<sqrtErr)
			sqrtErr = tempSqrtErr;
		else
			alpha(n) = alphaVector(k-1);
			% alpha(n) = 0.0;
			break
		end
	end
end
alpha(end) = alpha10;

end