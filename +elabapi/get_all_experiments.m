function [all_experiments, json_all_experiments] = get_all_experiments(options)
    % Get list of all experiments
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of all experiments.
    %
    %% Syntax:
    %   [all_experiments, json_all_experiments] = get_all_experiments()
    % or
    %   [all_experiments, json_all_experiments] = get_all_experiments(OPTIONS)
    %
    %% Input: optional
    %   OPTIONS [struct]:  structure with limit, offset and search fields
    %       OPTIONS.limit = 15; % default value
    %
    %% Output:
    %   all_experiments [struct]:  structure containing the list of experiments,
    %       each row corresponds to an experiment, and the different columns give
    %       the characteristics of this experiment.
    %
    %   json_all_experiments [string]:  JSON string describing the list of experiments 
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
    json_all_experiments = elabapi.send_req('experiments',options);
    try
        all_experiments = jsondecode(json_all_experiments);
    catch
        all_experiments = json_all_experiments;
    end
    %
    if isfield(CONFIG, 'pretty_json')
        json_all_experiments = jsonencode(all_experiments,"PrettyPrint",CONFIG.pretty_json);
    end
end