function [output, json_output] = add_tag_to_experiment(experiment_id,experiment_tag)
    % Add tag to experiment 
    %
    %% Description:
    % This function is part of eLabAPI and adds a tag to an experiment. 
    %   
    %% Syntax:
    %   add_tag_to_experiment(id,tag)
    % or
    %   add_tag_to_experiment(PARAMS)
    % or
    %   [RESULT, json_RESULT] = add_tag_to_experiment(id,tag)
    %
    %% Input:
    %   id [integer]:  ID of the specific experiment
    %   tag [string]:  tag string to add to the specified experiment
    % or
    %   PARAMS [struct]:  structure with id and tag fields
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
   
    if nargin ==1 && isfield(experiment_id,'id') && isfield(experiment_id,'tag')
        user_params = experiment_id;
        experiment_id = user_params.id;
        experiment_tag = user_params.tag;
    end

    [output, json_output] = elabapi.add_tag('experiments',experiment_id,experiment_tag);

end