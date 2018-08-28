function [ x ] = IF_TDMA( T,f )
%UNTITLED9 이 함수의 요약 설명 위치
%   자세한 설명 위치

len = length(f);
x = zeros(len,1);
bTemp = zeros(len,1);
aTemp = zeros(len,1);
cTemp = zeros(len,1);
height = size(T,1);

if(len>10)
	bTemp(1) = T(1,1);
	cTemp(1) = T(1,2);
	aTemp(len) = T(height,2);
	bTemp(len) = T(height,3);
	for n=2:5
		bTemp(n) = T(n,2);
		bTemp(len-n+1) = T(height-n+1,2);
		aTemp(n) = T(n,1);
		aTemp(len-n+1) = T(height-n+1,1);
		cTemp(n) = T(n,3);
		cTemp(len-n+1) = T(height-n+1,3);
	end
	for n=6:(len-5)
		bTemp(n) = T(6,2);
		aTemp(n) = T(6,1);
		cTemp(n) = T(6,3);
	end
	for n=2:len
		m = aTemp(n)/bTemp(n-1);
		bTemp(n) = bTemp(n)-m*cTemp(n-1);
		f(n) = f(n)-m*f(n-1);
	end
	x(len) = f(len)/bTemp(len);
	for n=(len-1):(-1):1
		x(n) = (f(n)-cTemp(n)*x(n+1))/bTemp(n);
	end
elseif(len>3)
	bTemp(1) = T(1,1);
	cTemp(1) = T(1,2);
	aTemp(len) = T(11,2);
	bTemp(len) = T(11,3);
	firstLen = floor(len/2);
	lastLen = len-firstLen;
	for n=2:firstLen
		bTemp(n) = T(n,2);
		aTemp(n) = T(n,1);
		cTemp(n) = T(n,3);
	end
	for n=2:lastLen
		bTemp(len-n+1) = T(height-n+1,2);
		aTemp(len-n+1) = T(height-n+1,1);
		cTemp(len-n+1) = T(height-n+1,3);
	end
	for n=2:len
		m = aTemp(n)/bTemp(n-1);
		bTemp(n) = bTemp(n) - m*cTemp(n-1);
		f(n) = f(n)-m*f(n-1);
	end
	x(len) = f(len)/bTemp(len);
	for n=(len-1):(-1):1
		x(n) = (f(n)-cTemp(n)*x(n+1))/bTemp(n);
	end
else
	disp('ERR(IF_TDMA): TDMA vector size is less than 4')
end

end

