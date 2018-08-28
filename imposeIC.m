function [ ux_ uy_, p_ ] = imposeIC( x,y,conf )
%	Initial condition is imposed on the field
[lenY,lenX] = size(x);
x0 = conf.x0;
y0 = conf.y0;
if(conf.dim==2)
	if(conf.inputPulseType==0)
		%No input
		p_ = zeros(lenY, lenX);
		ux_ = zeros(lenY,lenX);
		uy_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==1)
		%Gaussian point pulse
		sigma = conf.sigma;
		p_ = exp(-log(2).*((x-x0).^2+(y-y0).^2)./(sigma*sigma));
		ux_ = zeros(lenY,lenX);
		uy_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==2)
		%Gaussian line pulse
		sigma = conf.sigma;
		p_ = exp(-log(2).*((x-x0).^2)./(sigma*sigma));
		ux_ = zeros(lenY,lenX);
		uy_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==3)
		%Gaussian point source
		p_ = zeros(lenY, lenX);
		ux_ = zeros(lenY,lenX);
		uy_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==4)
		%Sinusoidal line pulse
		initialT0 = conf.initialT0;
		omegaC = 2.0*pi/initialT0;
		shiftX = 0.0;
		retardedT = initialT0-x./conf.c(1)+(shiftX/conf.c(1));
		mask = (0.0<retardedT).*(retardedT<(2.0*pi/omegaC));
		p_ = (-1.0*conf.rho(1))*(sin(omegaC*retardedT)-0.5*sin(2.0*omegaC*retardedT));
		ux_ = (-1.0/conf.c(1))*(sin(omegaC*retardedT)-0.5*sin(2.0*omegaC*retardedT));
		p_ = p_.*mask;
		ux_ = ux_.*mask;
		uy_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==5)
		%User-defined input pulse
		p_ = zeros(lenY, lenX);
		ux_ = zeros(lenY,lenX);
		uy_ = zeros(lenY,lenX);
	else
		fprintf('[ERR-imposeIC] Specify the inputPulseType (0~4)\n');
	end
else
	uy_ = 0;
	if(conf.inputPulseType==0)
		p_ = zeros(lenY, lenX);
		ux_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==1)
		fprintf('[WARNING-imposeIC] input type 1 cannot available in 1D case. Use inputPulseType=2 (redirect...)');
		sigma = conf.sigma;
		p_ = exp(-log(2).*((x-x0).^2)./(sigma*sigma));
		ux_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==2)
		sigma = conf.sigma;
		p_ = exp(-log(2).*((x-x0).^2)./(sigma*sigma));
		ux_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==3)
		p_ = zeros(lenY, lenX);
		ux_ = zeros(lenY,lenX);
	elseif(conf.inputPulseType==4)
		initialT0 = conf.initialT0;
		omegaC = 2.0*pi/initialT0;
		shiftX = 0.0;
		retardedT = initialT0-x./conf.c(1)+(shiftX/conf.c(1));
		mask = (0.0<retardedT).*(retardedT<(2.0*pi/omegaC));
		p_ = (-1.0*conf.rho(1))*(sin(omegaC*retardedT)-0.5*sin(2.0*omegaC*retardedT));
		ux_ = (-1.0/conf.c(1))*(sin(omegaC*retardedT)-0.5*sin(2.0*omegaC*retardedT));
		p_ = p_.*mask;
		ux_ = ux_.*mask;
	else
		fprintf('[ERR-imposeIC] Specify the inputPulseType (0~4)\n');
	end
end

end

