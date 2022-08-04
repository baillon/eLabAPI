function [status, json_status] = get_status()
    % Get list of status for current team
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of 
    %  experiment status, available for current team.
    %
    %% Syntax:
    %   [status, json_status] = get_status()
    %
    %% Input:
    %   [-]
    %
    %% Output:
    %   status [struct]:  structure containing the list of status,
    %       each row corresponds to a status, and the different columns give
    %       the characteristics of this status.
    %
    %   json_status [string]:  JSON string describing the list of
    %       status (same content as the structure)
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
    %
    %% Code
    CONFIG = elabapi.init();
    %
    json_status = elabapi.send_req('status');
    status = jsondecode(json_status);
    %
    if isfield(CONFIG, 'pretty_json')
        json_status = jsonencode(status,"PrettyPrint",CONFIG.pretty_json);
    end
end

