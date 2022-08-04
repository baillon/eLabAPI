function [all_templates, json_all_templates] = get_all_templates()
    % Get list of all templates
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of all templates.
    %
    %% Syntax:
    %   [all_templates, json_all_templates] = get_all_templates()
    %
    %% Input:
    %   [-]
    %
    %% Output:
    %   all_templates [struct]:  structure containing the list of templates,
    %       each row corresponds to a template, and the different columns give
    %       the characteristics of this template.
    %
    %   json_all_templates [string]:  JSON string describing the list of templates 
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
    json_all_templates = elabapi.send_req('templates');
    try
        all_templates = jsondecode(json_all_templates);
    catch
        all_templates = json_all_templates;
    end
    %
    if isfield(CONFIG, 'pretty_json')
        json_all_templates = jsonencode(all_templates,"PrettyPrint",CONFIG.pretty_json);
    end
end