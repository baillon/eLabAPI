function [item, json_item] = get_item(item_id)
    % Get item with specified id
    %
    %% Description:
    % This function is part of eLabAPI and gets an item specified by its ID.
    %
    %% Syntax:
    %   [item, json_item] = get_item(id)
    %
    %% Input: 
    %   id [integer]:  ID of the specific item
    %
    %% Output:
    %   item [struct]:  structure describing the item
    %
    %   json_item [string]:  JSON string describing the item 
    %       (same content as the structure)
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
    if ~nargin
        item_id=0;
    end
    params.id = item_id;
    [item, json_item] = elabapi.get_all_items(params);
end