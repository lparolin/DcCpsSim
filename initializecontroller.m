function Parameters = initializecontroller(Parameters)
%INITIALIZECONTROLLER Initialize the controller
%   

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% May 4th 2011

switch Parameters.Controller.controllerType
    case 'baseline'
        Parameters.Controller.initializecontroller = ...
            @initializebaselinecontroller;
        Parameters.Controller.synthesizecontrolinput = ...
            @synthesizebaselinecontrolinput;
        commandToExecute = {...
            'rootPath = pwd;'; ...
            'cd(''./controllers/data_center_level/baseline/'');'; ...
            'startup_baseline_controller;'; ...
            'cd(rootPath);'; ...
        };
    
    case 'coordinated'
        Parameters.Controller.initializecontroller = ...
            @initializecoordinatedcontroller;
        Parameters.Controller.synthesizecontrolinput = ...
            @synthesizecoordinatedcontrolinput;
        commandToExecute = {...
            'rootPath = pwd;'; ...
            'cd(''./controllers/data_center_level/coordinated/'');'; ...
            'startup_coordinated_controller;'; ...
            'cd(rootPath);'; ...
        };
    case 'stabilized_coordinated'
        Parameters.Controller.initializecontroller = ...
            @initializecoordinatedcontroller;
        Parameters.Controller.synthesizecontrolinput = ...
            @synthesizestabilizedcoordinatedcontrolinput;
        commandToExecute = {...
            'rootPath = pwd;'; ...
            'cd(''./controllers/data_center_level/stabilized_coordinated/'');'; ...
            'initializestabilizedcoordinatedcontroller;'; ...
            'cd(rootPath);'; ...
        };
    case 'target_coordinated'
        Parameters.Controller.initializecontroller = ...
            @initializetargetcoordinatedcontroller;
        Parameters.Controller.synthesizecontrolinput = ...
            @synthesizetargetcoordinatedcontrolinput;
        commandToExecute = {...
            'rootPath = pwd;'; ...
            'cd(''./controllers/data_center_level/target_coordinated/'');'; ...
            'startup_target_coordinated_controller;'; ...
            'cd(rootPath);'; ...
            };
    case 'uncoordinated'
        Parameters.Controller.initializecontroller = ...
            @initializeuncoordinatedcontroller;
        Parameters.Controller.synthesizecontrolinput = ...
            @synthesizeuncoordinatedcontrolinput;
    otherwise
        msgIdentComponent = upper(mfilename);
        msgIdentMnemonic = 'InputVariableCheck';
        msgIdent = [msgIdentComponent ':' msgIdentMnemonic];
        errorToThrow = MException(msgIdent, ...
            'Parameters.Controller.controller unknown value.');
        logandthrowerror(errorToThrow);
end

if exist('commandToExecute', 'var')
    if iscell(commandToExecute)
        for iCell = 1 : length(commandToExecute)
            eval(commandToExecute{iCell});
        end
    else
        eval(commandToExecute);
    end
end

Parameters = Parameters.Controller.initializecontroller(Parameters);

% start parallel code execution
if Parameters.Controller.isParallelExeuctionRequired
    isPoolRightSize = matlabpool('size') == Parameters.Controller.poolSize;
    if ~isPoolRightSize
        isPoolOpen = matlabpool('size') > 0;
        if isPoolOpen
            matlabpool('close');
        end
        matlabpool('open', Parameters.Controller.poolSize);
    end
else
    isPoolOpen = matlabpool('size') > 0;
    if isPoolOpen
        matlabpool('close');
    end
end

end

