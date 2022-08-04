function [items_types, json_items_types] = get_items_types()
    % Get list of items_types
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of items types
    % available in the database.
    %
    %% Syntax:
    %   [items_types, json_items_types] = get_items_types()
    %
    %% Input:
    %   [-]
    %
    %% Output:
    %   items_types [struct]:  structure containing the list of items types,
    %       each row corresponds to an item type, and the different columns give
    %       the characteristics of this item type.
    %
    %   json_items_types [string]:  JSON string describing the list of
    %       items types (same content as the structure)
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
    json_items_types = elabapi.send_req('items_types');
    items_types = jsondecode(json_items_types);
    %
    if isfield(CONFIG, 'pretty_json')
        json_items_types = jsonencode(items_types,"PrettyPrint",CONFIG.pretty_json);
    end
end

