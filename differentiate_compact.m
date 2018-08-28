function [ dfdx ] = differentiate_compact( f, x )
%   6th order compact finite difference scheme (Lele, JCP, 1992)
%	f and x are 1D vector

widthA = 5;
widthT = 3;
height = 5;

A = zeros(height,widthA);
A(1,:) = [-5 4 1 0 0];
A(2,:) = [-3 0 3 0 0];
A(3,:) = [-1/36 -7/9 0 7/9 1/36];
A(4,:) = [0 0 -3 0 3];
A(5,:) = [0 0 -1 -4 5];

T = zeros(height,widthT);
T(1,:) = [2 4 0];
T(2,:) = [1 4 1];
T(3,:) = [1/3 1 1/3];
T(4,:) = [1 4 1];
T(5,:) = [0 4 2];

len = length(f);
dfdx = zeros(size(f));
if(len>3)
	Af = differentiate_mult(A,f);
	Ax = differentiate_mult(A,x);
	f_ = differentiate_TDMA(T,Af);
	x_ = differentiate_TDMA(T,Ax);
	dfdx = f_./x_;
else
	dfdx = zeros(size(f));
end


end

