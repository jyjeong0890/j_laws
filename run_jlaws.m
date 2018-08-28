clear all
format 'long'
digits(15);

%% Set the parameters
conf = Config;

%%computation
p = timeMarchingManager(conf);
beep
%%postProcess
%p=visualizeData_2D( conf,10 );