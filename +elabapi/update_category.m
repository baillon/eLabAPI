function [output, json_output] = update_category(endpoint,id,category)
    % Update category of database item or experiment 
    %
    %% Description:
    % This function is part of eLabAPI and updates the category of a specific endpoint. 
    %   
    %% Syntax:
    %   update(endpoint,id,category)
    % or
    %   update(PARAMS)
    % or
    %   [RESULT, json_RESULT] = update(endpoint,id,category)
    %
    %% Input:
    %   endpoint [string]:  type of item
    %       endpoint {"items", "experiments"}
    %   id [integer]:  ID of the specific item
    %   category [integer]:  category of the database item or status of the
    %       experiment
    % or
    %   PARAMS [struct]:  structure with endpoint, id and category fields
    %       PARAMS {'endpoint', 'id','category'}
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
    if nargin ==1 && isfield(endpoint,'endpoint') && isfield(endpoint,'id') && isfield(endpoint,'category')
        user_params = endpoint;
        id = user_params.id;
        category = user_params.category;
        endpoint = user_params.endpoint;
    end
    params.endpoint = endpoint;
    params.id = id;
    params.category = category;
    %
    [output, json_output] = elabapi.update(params);

end