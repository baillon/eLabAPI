function [all_items, json_all_items] = get_all_items(options)
    % Get list of all items
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of items available
    % in the database.
    %
    %% Syntax:
    %   [all_items, json_all_items] = get_all_items()
    % or
    %   [all_items, json_all_items] = get_all_items(OPTIONS)
    %
    %% Input: optional
    %   OPTIONS [struct]:  structure with limit, offset and search fields
    %       OPTIONS.limit = 15; % default value
    %
    %% Output:
    %   all_items [struct]:  structure containing the list of items,
    %       each row corresponds to an item, and the different columns give
    %       the characteristics of this item.
    %
    %   json_all_items [string]:  JSON string describing the list of items 
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
    CONFIG = elabapi.init(); 
    %
    if ~nargin
        options=struct();
        options.limit = 15;
    end
    %
    json_all_items = elabapi.send_req('items',options);
    try
        all_items = jsondecode(json_all_items);
    catch
        all_items = json_all_items;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_all_items = jsonencode(all_items,"PrettyPrint",CONFIG.pretty_json);
    end
end