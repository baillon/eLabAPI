function [all_events, json_all_events] = get_all_events(options)
    % Get list of all events
    %
    %% Description:
    % This function is part of eLabAPI and gets the list of events in the scheduler.
    %
    %% Syntax:
    %   [all_events, json_all_events] = get_all_events()
    % or
    %   [all_events, json_all_events] = get_all_events(OPTIONS)
    %
    %% Input: optional
    %   OPTIONS [struct]:  structure with limit, offset and search fields
    %       OPTIONS.limit = 15; % default value
    %
    %% Output:
    %   all_events [struct]:  structure containing the list of events,
    %       each row corresponds to an event, and the different columns give
    %       the characteristics of this event.
    %
    %   json_all_events [string]:  JSON string describing the list of items 
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
    CONFIG = elabapi.init(); 
    %
    if ~nargin
        options=struct();
        options.limit = 15;
    end
    %
    json_all_events = elabapi.send_req('events',options);
    try
        all_events = jsondecode(json_all_events);
    catch
        all_events = json_all_events;
    end
    
    if isfield(CONFIG, 'pretty_json')
        json_all_events = jsonencode(all_events,"PrettyPrint",CONFIG.pretty_json);
    end
end