function [output, json_output] = create_item(category_id)
    % create a database item in category with id category_id
    %
    %% Description:
    % This function is part of eLabAPI and creates a new database item. 
    %   
    %% Syntax:
    %   create_item(id)
    % or
    %   create_item(PARAMS)
    % or
    %   [RESULT, json_RESULT] = create_item(id)
    %
    %% Input:
    %   id [integer]:  ID of the item category
    % or
    %   PARAMS [struct]:  structure with id field
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
    if nargin ==1 && isfield(category_id,'id')
        user_params = category_id;
        params.id = user_params.id;
    else
        params.id = category_id;
    end
    %
    json_output = elabapi.send_req('items',params,'create');

    try
        output = jsondecode(json_output);
    catch
        output = json_output;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_output = jsonencode(output,"PrettyPrint",CONFIG.pretty_json);
    end
end