function out_CONFIG = manager(endpoint,token)
    % define the manager
    %
    %% Description:
    % This function is part of eLabAPI and defines the manager. 
    %   
    %% Syntax:
    %   manager(endpoint,token)
    % or
    %   manager(CONFIG)
    % or
    %   CONFIG = manager(endpoint,token)
    %
    %% Input:
    %   endpoint [string]:  adress to the eLabFTW API 
    %   token [string]:  API Key generated from eLabFTW
    % or
    %   CONFIG [struct]:  structure with endpoint, token and possibly options
    %
    %% Output: optional
    %   CONFIG [struct]:  structure with endpoint, token and possibly options
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
    %   any later version. Also see the file "License.txt".

    %% Code
    if nargin && isstruct(endpoint)
        CONFIG = elabapi.init(endpoint);
    else
        options = struct();
        if nargin>0
            options.endpoint = endpoint;
        end
        if nargin>1
            options.token = token;
        end
        CONFIG = elabapi.init(options);
    end

    if nargout
        out_CONFIG = CONFIG;
    end

end