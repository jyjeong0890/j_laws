function [ err ] = IF_leastSquareErr( baseResponse, targetResponse )
%UNTITLED14 이 함수의 요약 설명 위치
%   자세한 설명 위치

partialSum = 0.0;
len = length(baseResponse);
len2 = length(targetResponse);

if(len~=len2)
	disp('ERR (IF_leastSquareErr) length of input vectors are different')
end

for n=1:len
	partialSum = partialSum + (baseResponse(n)-targetResponse(n))^2;
end
err = (partialSum/len);

end

