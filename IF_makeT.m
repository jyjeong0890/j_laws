function [ T ] = IF_makeT( alpha_f, height, widthT, rank_ )
%UNTITLED16 이 함수의 요약 설명 위치
%   자세한 설명 위치

T = zeros(height,widthT);

T(1,:) = [1.0,0.0,0.0];
T(end,:) = [0.0,0.0,1.0];
for m=2:rank_
	T(m,:) = [alpha_f(m-1), 1.0, alpha_f(m-1)];
	T(end-m+1,:) = [alpha_f(m-1), 1.0, alpha_f(m-1)];
end
m = rank_+1;
T(m,:) = [alpha_f(m-1), 1.0, alpha_f(m-1)];

end