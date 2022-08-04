function [output, json_output] = update(endpoint,id,params)
    % Update database item or experiment 
    %
    %% Description:
    % This function is part of eLabAPI and updates a specific endpoint. 
    %   
    %% Syntax:
    %   update(endpoint,id,PARAMS)
    % or
    %   update(PARAMS)
    % or
    %   [RESULT, json_RESULT] = update(endpoint,id,PARAMS)
    %
    %% Input:
    %   endpoint [string]:  type of item
    %       endpoint {"items", "experiments"}
    %   id [integer]:  ID of the specific item
    %   PARAMS [struct]:  structure with  all fields to update
    %       PARAMS {'tag','link','category','body','title','date','bodyappend','metadata'}
    % or
    %   PARAMS [struct]:  structure with endpoint, id and all fields to update
    %       PARAMS {'endpoint', 'id','tag','link','category','body','title','date','bodyappend','metadata'}
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
    if nargin ==1  && isfield(endpoint,'endpoint') && isfield(endpoint,'id')
        params = endpoint;
        id = params.id;
        endpoint = params.endpoint;
    else
        params.id = id;
    end
    %
    updatedFields = fieldnames(params);
    update_params = struct();
    update_params.id = id;
    for iF=1:numel(updatedFields)
        upField = updatedFields{iF};
        switch upField
            % tag, link and category must be update separately
            case 'tag'
                elabapi.add_tag(endpoint,id,params.tag);
            case 'link'
                elabapi.add_link(endpoint,id,params.link);
            case {'category','body'}
                oneParm=struct('id',id);
                oneParm.(upField) = params.(upField);
                elabapi.send_req(endpoint,oneParm,'update');
            case{'title','date','bodyappend','metadata'}
                % update all together
                update_params.(upField) = params.(upField);
        end
    end

    switch endpoint
        case {'experiments','items'}
            params = update_params;
            json_output = elabapi.send_req(endpoint,params,'update');
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