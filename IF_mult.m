function [ Af ] = IF_mult( A,f )
%UNTITLED10 이 함수의 요약 설명 위치
%   자세한 설명 위치

len = length(f);
Af = zeros(len,1);
temp = zeros(1,10);
widthA = size(A,2);
% temp1 = 0.0;

if(len>10)
	for n=1:5
		temp(n) = 0.0;
		for k=1:widthA
			temp(n) = temp(n)+A(n,k)*f(k);
		end
		Af(n) = temp(n);
	end
	for n=6:10
		temp(n) = 0.0;
		for k=1:widthA
			temp(n) = temp(n)+A(1+n,widthA-k+1)*f(len-k+1);
		end
		Af(len-10+n) = temp(n);
	end
	for n=6:(len-5)
		temp1 = 0.0;
		for k=1:widthA
			temp1 = temp1+A(6,k)*f(n+k-6);
		end
		Af(n) = temp1;
	end
elseif(len>3)
	firstLen = floor(len/2);
% 	lastLen = len-firstLen;
	for n=1:firstLen
		temp(n) = 0.0;
		for k=1:len
			temp(n) = temp(n)+A(12-n,widthA-k+1)*f(len-k+1);
		end
		Af(len-n+1) = temp(n);
	end
else
	Af = f;
end

end