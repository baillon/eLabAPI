function [event, json_event] = get_event(item_id)
    % Get event with specified id
    %
    %% Description:
    % This function is part of eLabAPI and gets an event specified by its ID.
    %
    %% Syntax:
    %   [event, json_event] = get_event(id)
    %
    %% Input: 
    %   id [integer]:  ID of the specific event
    %
    %% Output:
    %   event [struct]:  structure describing the event
    %
    %   json_event [string]:  JSON string describing the event 
    %       (same content as the structure)
    %
        %% Disclaimer:
    %   Last editor : Fabien Baillon
    %   Last edit on: 03.08.2022
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
        item_id=0;
    end
    params.id = item_id;
    [event, json_event] = elabapi.get_all_events(params);
end