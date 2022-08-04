function [all_bookable, json_all_bookable] = get_bookable()
    % Get only the bookable items
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of all the bookable items.
    %
    %% Syntax:
    %   [all_bookable, json_all_bookable] = get_bookable()
    %
    %% Input:
    %   [-]
    %
    %% Output:
    %   all_bookable [struct]:  structure containing the list of bookable items,
    %       each row corresponds to an item, and the different columns give
    %       the characteristics of this item.
    %
    %   json_all_bookable [string]:  JSON string describing the list of bookable items 
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
    json_all_bookable = elabapi.send_req('bookable');
    try
        all_bookable = jsondecode(json_all_bookable);
    catch
        all_bookable = json_all_bookable;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_all_bookable = jsonencode(all_bookable,"PrettyPrint",CONFIG.pretty_json);
    end
end