function [ response ] = IF_spectralFunction( wavenumber, orderIF, alpha10 )
%UNTITLED12 이 함수의 요약 설명 위치
%   자세한 설명 위치

N = floor(orderIF/2);
len = length(wavenumber);
response = zeros(1,len);

A = zeros(5,6);
if(orderIF==2)
	A(1,1) = 0.5+alpha10;
	A(1,2) = 0.5+alpha10;
elseif(orderIF==4)
	A(2,1) = (5.0/8.0) + (3.0/4.0)*alpha10;
	A(2,2) = 0.5+alpha10;
	A(2,3) = -1.0/8.0 + alpha10/4.0;
elseif(orderIF==6)
	A(3,1) = 11.0/16.0 + alpha10*5.0/8.0;
	A(3,2) = 15.0/32.0 + (17.0/16.0)*alpha10;
	A(3,3) = -3.0/16.0 + alpha10*3.0/8.0;
	A(3,4) = 1.0/32.0 - alpha10/16.0;
elseif(orderIF==8)
	A(4,1) = (93.0 + 70.0*alpha10)/128.0;
	A(4,2) = (7.0 + 18.0*alpha10)/16.0;
	A(4,3) = (-7.0 + 14.0*alpha10)/32.0;
	A(4,4) = 1.0/16.0 - alpha10/8.0;
	A(4,5) = -1.0/128.0 + alpha10/64.0;
elseif(orderIF==10)
	A(5,1) = (193.0 + 126.0*alpha10)/256.0;
	A(5,2) = (105.0 + 302.0*alpha10)/256.0;
	A(5,3) = 15.0*(-1.0 + 2.0*alpha10)/64.0;
	A(5,4) = 45.0*(1.0-2.0*alpha10)/512.0;
	A(5,5) = 5.0*(-1.0 + 2.0*alpha10)/256;
	A(5,6) = (1.0 - 2.0*alpha10)/512.0;
end

for n=1:len
	for k=1:(N+1)
		response(n) = response(n) + A(N,k)*cos(wavenumber(n)*(k-1));
	end
	response(n) = response(n)/(1.0+2.0*alpha10*cos(wavenumber(n)));
end

end

