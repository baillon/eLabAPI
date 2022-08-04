function [output, json_output] = create_event(id,userParams)
    % Create an event in the scheduler 
    %
    %% Description:
    % This function is part of eLabAPI and creates an event in the scheduler. 
    %   
    %% Syntax:
    %   create_event(id,PARAMS)
    % or
    %   create_event(PARAMS)
    % or
    %   [RESULT, json_RESULT] = create_event(id,PARAMS)
    %
    %% Input:
    %   id [integer]:  ID of the specific item
    %   PARAMS [struct]:  structure with fields to create event
    %       PARAMS {'start','end','title'}
    % or
    %   PARAMS [struct]:  structure with id and all fields to create event
    %       PARAMS {'id','start','end','title'}
    %
    %% Output: optional
    %   RESULT [struct]:  structure with result field
    %
    %   json_RESULT [string]: result JSON string (same content as the structure)
    %
    %% Disclaimer:
    %   Last editor : Fabien Baillon
    %   Last edit on: 03.08.2022
    %
    %   Copyright (c) 2022 Fabien Baillon.
    %
    %   This file is part of eLabAPI.
    %
    %   eLabAPI is free software: you can redistribute it and/or modify
    %   it under the terms of the GNU General Public License as published by
    %   the Free Software Foundation, either version 3 of the License, or
    %   any later version. Also see the file "License.mlx".

    %% Code   
    CONFIG = elabapi.init(); 
    %
    if nargin ==1  && isfield(id,'id')
        userParams = id;
        id = userParams.id;
    end
    %
    paramsFields = fieldnames(userParams);
    params = struct();
    params.id = id;
    for iF=1:numel(paramsFields)
        upField = paramsFields{iF};
        switch upField
            case{'title','start','end'}
                params.(upField) = userParams.(upField);
        end
    end

    userParams = params;
    json_output = elabapi.send_req('events',userParams,'update');
    try
        output = jsondecode(json_output);
    catch
        output = json_output;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_output = jsonencode(output,"PrettyPrint",CONFIG.pretty_json);
    end
end