function [ T ] = IF_makeT( alpha_f, height, widthT, rank_ )
%UNTITLED16 �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

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