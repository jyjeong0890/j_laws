function [ x ] = differentiate_TDMA( T,f )
%UNTITLED5 이 함수의 요약 설명 위치
%   자세한 설명 위치

len = length(f);
x = zeros(size(f));
bTemp = zeros(len,1);
aTemp = zeros(len,1);
cTemp = zeros(len,1);

if(len>4)
    bTemp(1) = T(1,1);
    bTemp(2) = T(2,2);
    bTemp(len-1) = T(4,2);
    bTemp(len) = T(5,3);
    
    aTemp(2) = T(2,1);
    aTemp(len-1) = T(4,1);
    aTemp(len) = T(5,2);
    
    cTemp(1) = T(1,2);
    cTemp(2) = T(2,3);
    cTemp(len-1) = T(4,3);
    
    bTemp(3:(len-2)) = T(3,2);
    aTemp(3:(len-2)) = T(3,1);
    cTemp(3:(len-2)) = T(3,3);
    
    m = aTemp(2)/bTemp(1);
    bTemp(2) = bTemp(2) - m*cTemp(1);
    f(2) = f(2)-m*f(1);
    %
    m = aTemp(3)/bTemp(2);
    bTemp(3) = bTemp(3) - m*cTemp(2);
    f(3) = f(3) - m*f(2);
    %
    for k=4:(len-2)
        m = aTemp(k)/bTemp(k-1);
        bTemp(k) = bTemp(k) - m*cTemp(k-1);
        f(k) = f(k) - m*f(k-1);
    end
    %
    m = aTemp(len-1)/bTemp(len-2);
    bTemp(len-1) = bTemp(len-1) - m*cTemp(len-2);
    f(len-1) = f(len-1) - m*f(len-2);
    %
    m = aTemp(len)/bTemp(len-1);
    bTemp(len) = bTemp(len) - m*cTemp(len-1);
    f(len) = f(len) - m*f(len-1);
    %
    x(len) = f(len)/bTemp(len);
    x(len-1) = (f(len-1)-cTemp(len-1)*x(len))/bTemp(len-1);
    for k=(len-2):(-1):3
        x(k) = (f(k)-cTemp(k)*x(k+1))/bTemp(k);
    end
    %
    x(2) = (f(2)-cTemp(2)*x(3))/bTemp(2);
    x(1) = (f(1)-cTemp(1)*x(2))/bTemp(1);
elseif(len==4)
    bTemp(1) = T(1,1);
    bTemp(2) = T(2,2);
    bTemp(3) = T(4,2);
    bTemp(4) = T(5,3);
    %
    aTemp(2) = T(2,1);
    aTemp(3) = T(4,1);
    aTemp(4) = T(5,2);
    %
    cTemp(1) = T(1,2);
    cTemp(2) = T(2,3);
    cTemp(3) = T(4,3);
    %
    m = aTemp(2)/bTemp(1);
    bTemp(2) = bTemp(2)-m*cTemp(1);
    f(2) = f(2)-m*f(1);
    %
    m = aTemp(3)/bTemp(2);
    bTemp(3) = bTemp(3)-m*cTemp(2);
    f(3) = f(3)-m*f(2);
    %
    m = aTemp(4)/bTemp(3);
    bTemp(4) = bTemp(4) - m*cTemp(3);
    f(4) = f(4)-m*f(3);
    %
    x(4) = f(4)/bTemp(4);
    x(3) = (f(3)-cTemp(3)*x(4))/bTemp(3);
    %
    x(2) = (f(2)-cTemp(2)*x(3))/bTemp(2);
    x(1) = (f(1)-cTemp(1)*x(2))/bTemp(1);
elseif(len==3)
    %
    bTemp(1) = T(1,1);
    bTemp(2) = T(2,2);
    bTemp(3) = T(5,3);
    %
    aTemp(2) = T(2,1);
    aTemp(3) = T(5,2);
    %
    cTemp(1) = T(1,2);
    cTemp(2) = T(2,3);
    %
    m = aTemp(2)/bTemp(1);
    bTemp(2) = bTemp(2)-m*cTemp(1);
    f(2) = f(2)-m*f(1);
    %
    m = aTemp(3)/bTemp(2);
    bTemp(3) = bTemp(3)-m*cTemp(2);
    f(3) = f(3)-m*f(2);
    %
    x(3) = f(3)/bTemp(3);
    x(2) = (f(2)-cTemp(2)*x(3))/bTemp(2);
    x(1) = (f(1)-cTemp(1)*x(2))/bTemp(1);
else
    disp('ERR (differentiate_TDMA): length of vector in TDMA is less than 3')
end

end