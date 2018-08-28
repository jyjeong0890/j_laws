function S = srcDist(x,y, conf )
	if(conf.dim==2)
		if(conf.inputPulseType==3)
			S = exp(-log(2).*((x-conf.x0).^2+(y-conf.y0).^2)./(conf.sigma*conf.sigma));
		else
			S = zeros(size(x));
		end
	elseif(conf.dim==1)
		if(conf.inputPulseType==3)
			exp(-log(2).*((x-conf.x0).^2)./(conf.sigma*conf.sigma));
		else
			S = zeros(size(x));
		end
	else
		fprintf('[ERR-srcDist] dimension number is out of range: %d\n',conf.dim);
	end

end