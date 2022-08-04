function [output, json_output] = destroy_event(id)
    % Delete an event in the scheduler 
    %
    %% Description:
    % This function is part of eLabAPI and deletes an event in the scheduler. 
    %   
    %% Syntax:
    %   destroy_event(id)
    % or
    %   [RESULT, json_RESULT] = create_event(id)
    %
    %% Input:
    %   id [integer]:  ID of the specific item
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
        id = userParams.id;
    end
    %
    params.id = id;

    json_output = elabapi.send_req('events',params,'delete');
    try
        output = jsondecode(json_output);
    catch
        output = json_output;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_output = jsonencode(output,"PrettyPrint",CONFIG.pretty_json);
    end
end