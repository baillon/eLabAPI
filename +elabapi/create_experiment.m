function [output, json_output] = create_experiment()
    % Create a new experiment 
    %
    %% Description:
    % This function is part of eLabAPI and creates a new experiment. 
    %   
    %% Syntax:
    %   create_experiment()
    % or
    %   [RESULT, json_RESULT] = create_experiment()
    %
    %% Input:
    %   [-]
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
    CONFIG = elabapi.init(); 
    %
    params = struct();
    json_output = elabapi.send_req('experiments',params,'create');

    try
        output = jsondecode(json_output);
    catch
        output = json_output;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_output = jsonencode(output,"PrettyPrint",CONFIG.pretty_json);
    end
end