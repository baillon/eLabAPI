function [output, json_output] = upload(endpoint,id,filename)
    % Upload a file to database item or experiment 
    %
    %% Description:
    % This function is part of eLabAPI and uploads a file to a specific endpoint. 
    %   
    %% Syntax:
    %   upload(endpoint,id,filename)
    % or
    %   upload(PARAMS)
    % or
    %   [RESULT, json_RESULT] = upload(endpoint,id,filename)
    %
    %% Input:
    %   endpoint [string]:  type of item
    %       endpoint {"items", "experiments"}
    %   id [integer]:  ID of the specific item
    %   filename [string]:  filename of the file to upload
    % or
    %   PARAMS [struct]:  structure with endpoint, id and file fields
    %       PARAMS {'endpoint','id','file'}
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
    if nargin ==1  && isfield(endpoint,'endpoint') && isfield(endpoint,'id') && isfield(endpoint,'file')
        user_params = endpoint;
        endpoint = user_params.endpoint;
        id = user_params.id;
        filename = user_params.file;
    end
    params.id = id;
    params.file = filename;

    %
    switch endpoint
        case {'experiments','items'}
            json_output = elabapi.send_req(endpoint,params,'upload');
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