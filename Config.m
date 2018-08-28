classdef Config < handle
    
    properties
        rho;
        % Density of
        c;
        
        deltaT;%time step size
        timeLimit;% duration
        deltaX;%grid size in the domain
        deltaY;
        innerPtX;%number of grid point in the domain
        innerPtY;
        domainSizeX;%domain size except for buffer zone
        domainSizeY;

        expRatio;
        % Grid stretching ratio in the buffer zone.
        % expRatio=2 is recommended.
        bufferPt;
        % Number of layers in the buffer zone.
        % bufferPt=10~12 is recommended
        filterAlpha;
        % Free parameter of the filter
        % This works
        % filterAlpha=0.45 is recommend
        writingInterval;%data is written with this interval
        cfl;
        gridType;
        %gridType
        %1=stretched buffer zone on each side
        %2=Uniform grid
        %3=custom
        %4=stretched buffer zozne on one side(x=0)
        resultDir;
        dim;
        inputPulseType;
        %inputPulseType=1->gaussian pulse
        %inputPulseType=2->gaussian line pulse
        %inputPulseType=4->sine line pulse
        sigma;%sigma of gaussian purterbation on initial condition
        freq;
        x0;% Center of Gaussian pulse at initial time
        y0;
        %for sine line pulse
        initialT0;
    end
    
    methods
        function obj = Config()
            obj.rho = 1.5;
            obj.c = 1.5;
            obj.deltaT = 0.01;
            obj.dim = 1;
            obj.deltaX = 0.03;
            obj.deltaY = 0.03;
            obj.timeLimit = 6.0;
            obj.innerPtX = 401;
            obj.innerPtY = 401;
            
            obj.expRatio = 2;
            obj.bufferPt = 11;
            obj.writingInterval = 10;
            obj.filterAlpha = 0.45;

            obj.x0 = 6.0;
            obj.y0 = 6.0;
            obj.sigma = 0.2;
            obj.initialT0 = 1.5;
            % at the interface, alpha=0.495 or larger
            % at the NBC, alpha=0.45 or smaller
            obj.resultDir = './testCase01/';
            
            obj.cfl = max(obj.c*(obj.deltaT)/(obj.deltaX));
            obj.domainSizeX = obj.deltaX*(obj.innerPtX-1);
            obj.domainSizeY = obj.deltaX*(obj.innerPtY-1);
            if(obj.resultDir(end)~='/')
                obj.resultDir = strcat(obj.resultDir,'/');
            end

            obj.inputPulseType = 2;
            %inputPulseType=1->gaussian pulse
            %inputPulseType=2->gaussian line pulse
            %inputPulseType=3->gaussian source
            %inputPulseType=4->sine line pulse
            obj.freq = 3;
            % freq is for the gaussian source
            obj.gridType = 1;
            obj.showInfo;
        end
        function showInfo(obj)
            nowT = datetime;
            disp(nowT)
            fprintf('Configuration of the IMM 2D code\n');
            fprintf('dimension: %f\n',obj.dim);
            fprintf('rho1: %f\n',obj.rho);
            fprintf('c1: %f\n',obj.c);
            fprintf('deltaT: %f\n',obj.deltaT);
            fprintf('timeLimit: %f\n',obj.timeLimit);
            fprintf('gridSize: (%f,%f)\n',obj.deltaX,obj.deltaY);
            fprintf('expRatio: %f\n',obj.expRatio);
            fprintf('bufferPt: %d\n',obj.bufferPt);
            fprintf('innerPtX: %d\n',obj.innerPtX);
            fprintf('innerPtY: %d\n',obj.innerPtY);
            fprintf('writingInterval: %d\n',obj.writingInterval);
            fprintf('result directory: %s\n',obj.resultDir);
            fprintf('filterAlpha: %f\n',obj.filterAlpha);
            fprintf('cfl: %f\n',obj.cfl);
            fprintf('domainSize: (%f,%f)\n',obj.domainSizeX,obj.domainSizeY);
            fprintf('source location: (%f, %f)\n',obj.x0, obj.y0);
        end
    end
    
end

