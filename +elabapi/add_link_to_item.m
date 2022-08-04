function [output, json_output] = add_link_to_item(item_id,item_link)
    % Add link database item to database item 
    %
    %% Description:
    % This function is part of eLabAPI and adds a link to a database item. 
    %   
    %% Syntax:
    %   add_link_to_item(id,link)
    % or
    %   add_link_to_item(PARAMS)
    % or
    %   [RESULT, json_RESULT] = add_link_to_item(id,link)
    %
    %% Input:
    %   id [integer]:  ID of the specific item
    %   link [integer]:  ID of the database item to link to the specified item 
    % or
    %   PARAMS [struct]:  structure with id and link fields
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
    if nargin ==1 && isfield(item_id,'id') && isfield(item_id,'link')
        user_params = item_id;
        item_id = user_params.id;
        item_link = user_params.link;
    end

    [output, json_output] = elabapi.add_link('items',item_id,item_link);

end