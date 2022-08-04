function [experiment, json_experiment] = get_experiment(experiment_id)
    % Get experiment with specified id
    %
    %% Description:
    % This function is part of eLabAPI and gets an experiment specified by its ID.
    %
    %% Syntax:
    %   [experiment, json_experiment] = get_experiment(id)
    %
    %% Input: 
    %   id [integer]:  ID of the specific experiment
    %
    %% Output:
    %   item [struct]:  structure describing the experiment
    %
    %   json_item [string]:  JSON string describing the experiment 
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
        experiment_id=0;
    end
    params.id = experiment_id;
    [experiment, json_experiment] = elabapi.get_all_experiments(params);
end