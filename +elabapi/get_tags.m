function [all_tags, json_all_tags] = get_tags()
    % Get list of all tags
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of all tags.
    %
    %% Syntax:
    %   [all_tags, json_all_tags] = get_tags()
    %
    %% Input:
    %   [-]
    %
    %% Output:
    %   all_tags [struct]:  structure containing the list of tags,
    %       each row corresponds to a tag, and the second column is its ID.
    %
    %   json_all_tags [string]:  JSON string describing the list tags 
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
    json_all_tags = elabapi.send_req('tags');
    try
        all_tags = jsondecode(json_all_tags);
    catch
        all_tags = json_all_tags;
    end
    %
    if isfield(CONFIG, 'pretty_json')
        json_all_tags = jsonencode(all_tags,"PrettyPrint",CONFIG.pretty_json);
    end
end