function [ A ] = IF_makeA(alpha_f, height, widthA, order_)
	A = zeros(height,widthA);
	A(1,1) = 1.0;
	k=1;
	while(k<5)
		m=0;
		n=k;
		while(m<widthA)
			if(m<k)
				A(k+1,m+1) = ACoeff(k,n, order_, alpha_f)/2.0;
				n = n-1;
			elseif(m==k)
				A(k+1,m+1) = ACoeff(k,n, order_, alpha_f);
				n = n+1;
			elseif(m>k)
				A(k+1,m+1) = ACoeff(k,n, order_, alpha_f)/2.0;
				n = n+1;
			end
			m=m+1;
		end
		k=k+1;
	end
	A(11,11) = 1.0;
	k=1;
	while(k<5)
		m=0;
		n=k;
		while(m<widthA)
			if(m<k)
				A(11-k,11-m) = ACoeff(k,n, order_, alpha_f)/2.0;
				n=n-1;
			elseif(m==k)
				A(11-k,11-m) = ACoeff(k,n, order_, alpha_f);
				n=n+1;
			elseif(m>k)
				A(11-k,11-m) = ACoeff(k,n, order_, alpha_f)/2.0;
				n=n+1;
			end
			m=m+1;
		end
		k=k+1;
	end
	m=0;
	n=5;
	while(m<widthA)
		if(m<5)
			A(6,m+1) = ACoeff(5,n, order_, alpha_f)/2.0;
			n=n-1;
		elseif(m==5)
			A(6,m+1) = ACoeff(5,n, order_, alpha_f);
			n=n+1;
		elseif(m>5)
			A(6,m+1) = ACoeff(5,n, order_, alpha_f)/2.0;
			n=n+1;
		end
		m=m+1;
	end
end

function coeff = ACoeff(n, m, order_,alpha_f)
    if(order_==2)
        coeff = A2Coeff(n,m, alpha_f);
    elseif(order_==4)
    	coeff = A4Coeff(n,m, alpha_f);
    elseif(order_==6)
    	coeff = A6Coeff(n,m, alpha_f);
    elseif(order_==8)
    	coeff = A8Coeff(n,m, alpha_f);
    elseif(order_==10)
    	coeff = A10Coeff(n,m, alpha_f);
    else
    	disp('ERR(ACoeff): order is out of range')
    	coeff = -1;
    end
end

function coeff = A10Coeff(n, m, alpha_f)
	if(n==0)
		if(m==0)
			coeff = 1.0;
		else
			coeff = 0.0;
		end
	elseif(n==1)
		coeff = Filter2Coeff(m, alpha_f);
	elseif(n==2)
		coeff = Filter4Coeff(m, alpha_f);
	elseif(n==3)
		coeff = Filter6Coeff(m, alpha_f);
	elseif(n==4)
		coeff = Filter8Coeff(m, alpha_f);
	elseif(n==5)
		coeff = Filter10Coeff(m, alpha_f);
	else
		disp('ERR(A10Coeff): idx is out of range')
	end
end

function coeff = A8Coeff(n, m, alpha_f)
	if(n==0)
		if(m==0)
			coeff = 1.0;
		else
			coeff = 0.0;
		end
	elseif(n==1)
		coeff = Filter2Coeff(m, alpha_f);
	elseif(n==2)
		coeff = Filter4Coeff(m, alpha_f);
	elseif(n==3)
		coeff = Filter6Coeff(m, alpha_f);
	elseif((n==4)||(n==5))
		coeff = Filter8Coeff(m, alpha_f);
	else
		disp('ERR(A8Coeff): idx is out of range')
	end
end

function coeff = A6Coeff(n, m, alpha_f)
	if(n==0)
		if(m==0)
			coeff = 1.0;
		else
			coeff = 0.0;
		end
	elseif(n==1)
		coeff = Filter2Coeff(m, alpha_f);
	elseif(n==2)
		coeff = Filter4Coeff(m, alpha_f);
	elseif((n>2)&(n<6))
		coeff = Filter6Coeff(m, alpha_f);
	else
		disp('ERR(A6Coeff): idx is out of range')
	end
end

function coeff = A4Coeff(n, m, alpha_f)
	if(n==0)
		if(m==0)
			coeff = 1.0;
		else
			coeff = 0.0;
		end
	elseif(n==1)
		coeff = Filter2Coeff(m, alpha_f);
	elseif((n>1)&(n<6))
		coeff = Filter4Coeff(m, alpha_f);
	else
		disp('ERR(A4Coeff): idx is out of range')
	end
end

function coeff = A2Coeff(n, m, alpha_f)
	if(n==0)
		if(m==0)
			coeff = 1.0;
		else
			coeff = 0.0;
		end
	elseif((n>0)&(n<6))
		coeff = Filter2Coeff(m, alpha_f);
	else
		disp('ERR(A2Coeff): idx is out of range')
	end
end

function coeff = Filter10Coeff(n, alpha_f)
	if(n==0)
		coeff = (193.0+126.0*alpha_f(5))/256.0;
	elseif(n==1)
		coeff = (105.0+302.0*alpha_f(5))/256.0;
	elseif(n==2)
		coeff = 15.0*(-1.0+2.0*alpha_f(5))/64.0;
	elseif(n==3)
		coeff = 45.0*(1.0-2.0*alpha_f(5))/512.0;
	elseif(n==4)
		coeff = 5.0*(-1.0+2.0*alpha_f(5))/256.0;
	elseif(n==5)
		coeff = (1.0-2.0*alpha_f(5))/512.0;
	else
		coeff = 0.0;
	end
end

function coeff = Filter8Coeff(n, alpha_f)
	if(n==0)
		coeff = (93.0+70.0*alpha_f(4))/128.0;
	elseif(n==1)
		coeff = (7.0+18.0*alpha_f(4))/16.0;
	elseif(n==2)
		coeff = (-7.0+14.0*alpha_f(4))/32.0;
	elseif(n==3)
		coeff = (1.0/16.0)-(alpha_f(4)/8.0);
	elseif(n==4)
		coeff = (-1.0/128.0)+(alpha_f(4)/64.0);
	else
		coeff = 0.0;
	end
end

function coeff = Filter6Coeff(n, alpha_f)
	if(n==0)
		coeff = (11.0/16.0)+(5.0*alpha_f(3)/8.0);
	elseif(n==1)
		coeff = (15.0/32.0)+(17.0*alpha_f(3)/16.0);
	elseif(n==2)
		coeff = (-3.0/16.0)+(3.0*alpha_f(3)/8.0);
	elseif(n==3)
		coeff = (1.0/32.0)-(alpha_f(3)/16.0);
	else
		coeff = 0.0;
	end
end

function coeff = Filter4Coeff(n, alpha_f)
	if(n==0)
		coeff = (5.0/8.0)+(3.0*alpha_f(2)/4.0);
	elseif(n==1)
		coeff = (1.0/2.0)+alpha_f(2);
	elseif(n==2)
		coeff = (-1.0/8.0)+alpha_f(2)/4.0;
	else
		coeff = 0.0;
	end
end

function coeff = Filter2Coeff(n, alpha_f)
	if((n==0)|(n==1))
		coeff = ((1.0/2.0)+alpha_f(1));
	else
		coeff = 0.0;
	end
end

