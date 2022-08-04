function [output, json_output] = post_item(item_id,params)
    % Update database item 
    %
    %% Description:
    % This function is part of eLabAPI and updates a database item. 
    %   
    %% Syntax:
    %   post_item(id,PARAMS)
    % or
    %   post_item(PARAMS)
    % or
    %   [RESULT, json_RESULT] = post_item(id,PARAMS)
    %
    %% Input:
    %   id [integer]:  ID of the database item
    %   PARAMS [struct]:  structure with  all fields to update
    %       PARAMS {'tag','link','category','body','title','date','bodyappend','metadata'}
    % or
    %   PARAMS [struct]:  structure with id and all fields to update
    %       PARAMS {'id','tag','link','category','body','title','date','bodyappend','metadata'}
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
    if nargin ==1 && isfield(item_id,'id') 
        params = item_id;
        item_id = params.id;
    end
    % 
   [output, json_output] = elabapi.update('items',item_id,params);
end