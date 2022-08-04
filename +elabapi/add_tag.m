function [output, json_output] = add_tag(endpoint,id,tag)
    % Add tag to endpoint 
    %
    %% Description:
    % This function is part of eLabAPI and adds a tag to an item defined by its ID, 
    % and its type 'items' or 'experiments'. 
    %   
    %% Syntax:
    %   add_tag(endpoint,id,tag)
    % or
    %   add_tag(PARAMS)
    % or
    %   [RESULT, json_RESULT] = add_tag(endpoint,id,tag)
    %
    %% Input:
    %   endpoint [string]:  type of item
    %       endpoint {"items", "experiments"}
    %   id [integer]:  ID of the specific item
    %   tag [string]:  tag string to add to the item specified
    % or
    %   PARAMS [struct]:  structure with endpoint, id and tag fields
    %
    %% Output: optional
    %   RESULT [struct]:  structure with result field
    %
    %   json_RESULT [string]: result JSON string (same content as the structure)
    %
    %% Disclaimer:
    %   Last editor : Fabien Baillon
    %   Last edit on: 29.07.2022
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
    if nargin ==1 && isfield(endpoint,'endpoint') && isfield(endpoint,'id') && isfield(endpoint,'tag')
        user_params = endpoint;
        params.id = user_params.id;
        params.tag = user_params.tag;
        endpoint = user_params.endpoint;
    else
        params.id = id;
        params.tag = tag;
    end
    %
    switch endpoint
        case {'experiments','items'}
            json_output = elabapi.send_req(endpoint,params,'add');
        otherwise
            json_output = '{result: erreur, endpoint inconnu !}';
    end
    try
        output = jsondecode(json_output);
    catch
        output = json_output;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_output = jsonencode(output,"PrettyPrint",CONFIG.pretty_json);
    end
end