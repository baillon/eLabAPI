function [output, json_output] = add_tag_to_item(item_id,item_tag)
    % add tag to database item 
     %
    %% Description:
    % This function is part of eLabAPI and adds a tag to an database item. 
    %   
    %% Syntax:
    %   add_tag_to_item(id,tag)
    % or
    %   add_tag(PARAMS)
    % or
    %   [RESULT, json_RESULT] = add_tag_to_item(id,tag)
    %
    %% Input:
    %   id [integer]:  ID of the specific item
    %   tag [string]:  tag string to add to the specified item 
    % or
    %   PARAMS [struct]:  structure with id and tag fields
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
    if nargin ==1 && isfield(item_id,'id') && isfield(item_id,'tag')
        user_params = item_id;
        item_id = user_params.id;
        item_tag = user_params.tag;
    end

    [output, json_output] = elabapi.add_tag('items',item_id,item_tag);

end