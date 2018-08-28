classdef RK4_1D_Marching
%   Use Runge-Kutta 4th order time-integration
    properties
        filterModule;
        conf;
        x;
        src;
        F_subStep;
        H_subStep;
        freq;
    end
    
    methods
        function obj = RK4_1D_Marching(x_,config,filterModule_)
            obj.conf = config;
            obj.filterModule = filterModule_;
            obj.x=x_;
            obj.F_subStep = cell(1,4);
            obj.H_subStep = cell(1,4);
            obj.freq = config.freq;
            obj.src = srcDist(x_,0,config);
        end
        function [ux_next, p_next, currentTime] = march(obj,ux_prev, p_prev, currentTime)
            ux_base = ux_prev;
            p_base = p_prev;
            rho = obj.conf.rho;
            c = obj.conf.c;
            modulus = rho*c^2;
            dt = obj.conf.deltaT;
            subTime = currentTime;
            src = obj.src.*sin(2*pi*obj.freq*subTime);
            [lenY, lenX] = size(obj.x);
            %clearing
            for n=1:4
                obj.F_subStep{1,n} = zeros(lenY,lenX);
                obj.H_subStep{1,n} = zeros(lenY,lenX);
            end
            %k1
            subLevel=1;
            obj.F_subStep{1,subLevel} = -1.0*differentiate_compact(p_prev,obj.x)/rho;
            obj.H_subStep{1,subLevel} = -1.0*differentiate_compact(ux_prev,obj.x)*modulus;
            
            ux_prev = ux_base+(dt/2)*obj.F_subStep{1,subLevel};
            p_prev = p_base+(dt/2)*obj.H_subStep{1,subLevel};
            subTime = currentTime+(dt/2);
            src = obj.src*sin(2*pi*obj.freq*subTime);

            %k2
            subLevel=2;
            obj.F_subStep{1,subLevel} = -1.0*differentiate_compact(p_prev,obj.x)/rho;
            obj.H_subStep{1,subLevel} = -1.0*differentiate_compact(ux_prev,obj.x)*modulus;
            ux_prev = ux_base+(dt/2)*obj.F_subStep{1,subLevel};
            p_prev = p_base+(dt/2)*obj.H_subStep{1,subLevel};
            
            %k3
            subLevel=3;
            obj.F_subStep{1,subLevel} = -1.0*differentiate_compact(p_prev,obj.x)/rho;
            obj.H_subStep{1,subLevel} = -1.0*differentiate_compact(ux_prev,obj.x)*modulus;
            ux_prev = ux_base+(dt)*obj.F_subStep{1,subLevel};
            p_prev = p_base+(dt)*obj.H_subStep{1,subLevel};
            subTime = currentTime+(dt);
            src = obj.src*sin(2*pi*obj.freq*subTime);
            %k4
            subLevel=4;
            obj.F_subStep{1,subLevel} = -1.0*differentiate_compact(p_prev,obj.x)/rho;
            obj.H_subStep{1,subLevel} = -1.0*differentiate_compact(ux_prev,obj.x)*modulus;
            
            %Sumup
            sumF = (obj.F_subStep{1,1}+2*obj.F_subStep{1,2}+2*obj.F_subStep{1,3}+obj.F_subStep{1,4})*(obj.conf.deltaT)/6;
            sumH = (obj.H_subStep{1,1}+2*obj.H_subStep{1,2}+2*obj.H_subStep{1,3}+obj.H_subStep{1,4})*(obj.conf.deltaT)/6;
            ux_next = ux_base+sumF;
            p_next = p_base+sumH;
            %filtering
            ux_next = obj.filterModule.filtering(ux_next);
            p_next = obj.filterModule.filtering(p_next);

            currentTime = subTime;
            % bc imposing
            ux_next(1)=0;
            p_next(1)=(18*p_next(2)-9*p_next(3)+2*p_next(4))/11;
            ux_next(end)=0;
            p_next(end)=(18*p_next(end-1)-9*p_next(end-2)+2*p_next(end-3))/11;

            % Before the code, high frequency wave is reflected from the buffer zone.
            % This problem can be fixed applying the filter to the u_next, not uSpr, and change the order of filtering and BC imposition. (BC imposition->filtering)

            % Filtering part can be problematic because head and tail of target stencil has different medium from body of stencil. 
            % Especially in the case of high impedance ratio, this problem is expected to rise. If so, extra segmentation profile is inserted before the loop.

        end
        
    end
end
