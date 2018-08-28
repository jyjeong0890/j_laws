classdef RK4_2D_Marching
%   Use Runge-Kutta 4th order time-integration
    properties
        filterModule;
        conf;
        x;
        y;
        src;
        F_subStep;
        G_subStep;
        H_subStep;
        freq;
    end
    
    methods
        function obj = RK4_2D_Marching(x_,y_,config,filterModule_)
            obj.conf = config;
            obj.filterModule = filterModule_;
            obj.x=x_;
            obj.y=y_;
            obj.F_subStep = cell(1,4);
            obj.G_subStep = cell(1,4);
            obj.H_subStep = cell(1,4);
            obj.freq = config.freq;
            obj.src = srcDist(x_,y_,conf);
            end
        end
        
        function [ux_next, uy_next, p_next, currentTime] = march(obj,ux_prev, uy_prev, p_prev, currentTime)
            ux_base = ux_prev;
            uy_base = uy_prev;
            p_base = p_prev;
            rho = obj.conf.rho;
            c = obj.conf.c;
            dt = obj.conf.deltaT;
            modulus = rho*c^2;
            subTime = currentTime;
            [lenY, lenX] = size(obj.x);
            src = obj.src.*sin(2*pi*obj.freq*subTime);
            %clearing
            for n=1:4
                obj.F_subStep{1,n} = zeros(lenY,lenX);
                obj.G_subStep{1,n} = zeros(lenY,lenX);
                obj.H_subStep{1,n} = zeros(lenY,lenX);
            end
            %k1
            subLevel=1;
            for n1=1:lenY
                tempX = obj.x(n1,:);
                tempP = p_prev(n1,:);
                tempUx = ux_prev(n1,:);
                obj.F_subStep{1,subLevel}(n1,:) = -1.0*differentiate_compact(tempP,tempX)/rho;
                obj.H_subStep{1,subLevel}(n1,:) = obj.H_subStep{1,subLevel}(n1,:)-differentiate_compact(tempUx,tempX)*modulus;
            end
            for n2=1:lenX
                tempY = obj.y(:,n2);
                tempP = p_prev(:,n2);
                tempUy = uy_prev(:,n2);
                obj.G_subStep{1,subLevel}(:,n2) = -1.0*differentiate_compact(tempP,tempY)/rho;
                obj.H_subStep{1,subLevel}(:,n2) = obj.H_subStep{1,subLevel}(:,n2) - differentiate_compact(tempUy,tempY)*modulus+src(:,n2);
            end
            ux_prev = ux_base+(dt/2)*obj.F_subStep{1,subLevel};
            uy_prev = uy_base+(dt/2)*obj.G_subStep{1,subLevel};
            p_prev = p_base+(dt/2)*obj.H_subStep{1,subLevel};
            subTime = currentTime+(dt/2);
            src = obj.src*sin(2*pi*obj.freq*subTime);
            %k2
            subLevel=2;
            for n1=1:lenY
                tempX = obj.x(n1,:);
                tempP = p_prev(n1,:);
                tempUx = ux_prev(n1,:);
                obj.F_subStep{1,subLevel}(n1,:) = -1.0*differentiate_compact(tempP,tempX)/rho;
                obj.H_subStep{1,subLevel}(n1,:) = obj.H_subStep{1,subLevel}(n1,:)-differentiate_compact(tempUx,tempX)*modulus;
            end
            for n2=1:lenX
                tempY = obj.y(:,n2);
                tempP = p_prev(:,n2);
                tempUy = uy_prev(:,n2);
                obj.G_subStep{1,subLevel}(:,n2) = -1.0*differentiate_compact(tempP,tempY)/rho;
                obj.H_subStep{1,subLevel}(:,n2) = obj.H_subStep{1,subLevel}(:,n2) - differentiate_compact(tempUy,tempY)*modulus+src(:,n2);
            end
            ux_prev = ux_base+(dt/2)*obj.F_subStep{1,subLevel};
            uy_prev = uy_base+(dt/2)*obj.G_subStep{1,subLevel};
            p_prev = p_base+(dt/2)*obj.H_subStep{1,subLevel};
            %k3
            subLevel=3;
            for n1=1:lenY
                tempX = obj.x(n1,:);
                tempP = p_prev(n1,:);
                tempUx = ux_prev(n1,:);
                obj.F_subStep{1,subLevel}(n1,:) = -1.0*differentiate_compact(tempP,tempX)/rho;
                obj.H_subStep{1,subLevel}(n1,:) = obj.H_subStep{1,subLevel}(n1,:)-differentiate_compact(tempUx,tempX)*modulus;
            end
            for n2=1:lenX
                tempY = obj.y(:,n2);
                tempP = p_prev(:,n2);
                tempUy = uy_prev(:,n2);
                obj.G_subStep{1,subLevel}(:,n2) = -1.0*differentiate_compact(tempP,tempY)/rho;
                obj.H_subStep{1,subLevel}(:,n2) = obj.H_subStep{1,subLevel}(:,n2) - differentiate_compact(tempUy,tempY)*modulus+src(:,n2);
            end
            ux_prev = ux_base+(dt)*obj.F_subStep{1,subLevel};
            uy_prev = uy_base+(dt)*obj.G_subStep{1,subLevel};
            p_prev = p_base+(dt)*obj.H_subStep{1,subLevel};
            subTime = currentTime+(dt);
            src = obj.src*sin(2*pi*obj.freq*subTime);
            %k4
            subLevel=4;
            for n1=1:lenY
                tempX = obj.x(n1,:);
                tempP = p_prev(n1,:);
                tempUx = ux_prev(n1,:);
                obj.F_subStep{1,subLevel}(n1,:) = -1.0*differentiate_compact(tempP,tempX)/rho;
                obj.H_subStep{1,subLevel}(n1,:) = obj.H_subStep{1,subLevel}(n1,:)-differentiate_compact(tempUx,tempX)*modulus;
            end
            for n2=1:lenX
                tempY = obj.y(:,n2);
                tempP = p_prev(:,n2);
                tempUy = uy_prev(:,n2);
                obj.G_subStep{1,subLevel}(:,n2) = -1.0*differentiate_compact(tempP,tempY)/rho;
                obj.H_subStep{1,subLevel}(:,n2) = obj.H_subStep{1,subLevel}(:,n2) - differentiate_compact(tempUy,tempY)*modulus+src(:,n2);
            end
            sumF = (obj.F_subStep{1,1}+2*obj.F_subStep{1,2}+2*obj.F_subStep{1,3}+obj.F_subStep{1,4})*(dt)/6;
            sumG = (obj.G_subStep{1,1}+2*obj.G_subStep{1,2}+2*obj.G_subStep{1,3}+obj.G_subStep{1,4})*(dt)/6;
            sumH = (obj.H_subStep{1,1}+2*obj.H_subStep{1,2}+2*obj.H_subStep{1,3}+obj.H_subStep{1,4})*(dt)/6;
            ux_next = ux_base+sumF;
            uy_next = uy_base+sumG;
            p_next = p_base+sumH;
            %filtering
            for n1=1:lenY
                tempP = p_next(n1,:);
                tempUx = ux_next(n1,:);
                tempUy = uy_next(n1,:);
                p_next(n1,:) = obj.filterModule.filtering(tempP);
                ux_next(n1,:) = obj.filterModule.filtering(tempUx);
                uy_next(n1,:) = obj.filterModule.filtering(tempUy);
            end
            for n2=1:lenX
                tempP = p_next(:,n2);
                tempUx = ux_next(:,n2);
                tempUy = uy_next(:,n2);
                p_next(:,n2) = obj.filterModule.filtering(tempP);
                ux_next(:,n2) = obj.filterModule.filtering(tempUx);
                uy_next(:,n2) = obj.filterModule.filtering(tempUy);
            end
            currentTime = subTime;
            % bc imposing
            ux_next(:,1)=0;
            uy_next(:,1)=0;
            p_next(:,1)=(18*p_next(:,2)-9*p_next(:,3)+2*p_next(:,4))/11;
            ux_next(:,end)=0;
            uy_next(:,end)=0;
            p_next(:,end)=(18*p_next(:,end-1)-9*p_next(:,end-2)+2*p_next(:,end-3))/11;
            
            ux_next(1,:)=0;
            uy_next(1,:)=0;
            p_next(1,:)=(18*p_next(2,:)-9*p_next(3,:)+2*p_next(4,:))/11;
            ux_next(end,:)=0;
            uy_next(end,:)=0;
            p_next(end,:)=(18*p_next(end-1,:)-9*p_next(end-2,:)+2*p_next(end-3,:))/11;

            % Before the code, high frequency wave is reflected from the buffer zone.
            % This problem can be fixed applying the filter to the u_next, not uSpr, and change the order of filtering and BC imposition. (BC imposition->filtering)

            % Filtering part can be problematic because head and tail of target stencil has different medium from body of stencil. 
            % Especially in the case of high impedance ratio, this problem is expected to rise. If so, extra segmentation profile is inserted before the loop.

        end
        
    end
end
