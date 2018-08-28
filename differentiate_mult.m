function [ Af ] = differentiate_mult( A, f )
%UNTITLED3 이 함수의 요약 설명 위치
%   자세한 설명 위치

len = length(f);
Af = zeros(size(f));
temp = zeros(1,4);
widthA = size(A,2);
if(widthA>len)
    tempWidth = len;
else
    tempWidth = widthA;
end

if(len>3)
    for n=1:tempWidth
        temp(1) = temp(1) + A(1,n)*f(n);
        temp(2) = temp(2) + A(2,n)*f(n);
        temp(3) = temp(3) + A(4,widthA-n+1)*f(len-n+1);
        temp(4) = temp(4) + A(5,widthA-n+1)*f(len-n+1);
    end
    Af(1) = temp(1);
    Af(2) = temp(2);
    Af(len-1) = temp(3);
    Af(len) = temp(4);
    for k=3:(len-2)
        temp(1) = 0;
        for n=1:tempWidth
            temp(1) = temp(1) + A(3,n)*f(n+k-3);
        end
        Af(k) = temp(1);
    end
elseif(len==3)
    for n=1:tempWidth
        temp(1) = temp(1) + A(1,n)*f(n);
        temp(2) = temp(2) + A(2,n)*f(n);
        temp(4) = temp(4) + A(5,widthA-n+1)*f(len-n+1);
    end
    Af(1) = temp(1);
    Af(2) = temp(2);
    Af(3) = temp(3);
else
    disp('ERR (differentiate_mult): vector size is less than 3')
end
    

end

