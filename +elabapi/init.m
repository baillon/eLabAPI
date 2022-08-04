function out_CONFIG = init(options)
    % init the API configuration
    %% Description:
    % This function is part of eLabAPI and initializes the API configuration. 
    % The configuration is saved in a JSON file named CONFIG.JSON.
    % If no options are provided to this function, the CONFIG.JSON file is read
    % to initialise the configuration. If options are provided, the configuration is
    % updated, along with the JSON file.  
    %% Syntax:
    %   init(options)
    % or
    %   CONFIG = init(options)
    %
    %% Input:
    %   options [struct]:  structure with endpoint, token and possibly
    %       options {'endpoint','token','pretty_json'}
    %
    %% Output: optional
    %   CONFIG [struct]:  structure with endpoint, token and possibly
    %       options {'endpoint','token','pretty_json'}
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
    persistent CONFIG 

    info.description = "A matlab module to interact with elabftw API";
    info.version = "0.1.1";
    info.author = "Fabien BAILLON";
    info.author_email = "fabien.baillon@imt-mines-albi.fr";
    info.license = "GPL v3";
    info.copyright = "Copyright (©) 2022 Fabien BAILLON";
    %
    if isempty(CONFIG), disp(info), end
    %
    if nargin && isstruct(options)
        autorized_fieldnames_CONFIG = {'endpoint','token','pretty_json'};
        optionsNames = fieldnames(options);
        for iF=1:numel(optionsNames)
            if any(contains(autorized_fieldnames_CONFIG,optionsNames{iF}))
                CONFIG.(optionsNames{iF}) = options.(optionsNames{iF});
            end
        end
    end
    
    %
    CONFIG_Filename = fullfile(userpath,"CONFIG_eLabAPI.json");
    %
    % la structure CONFIG contient les éléments de configuration pour
    % l'accès à l'api d'elabFTW
    if isempty(CONFIG)
        fprintf("reading the configuration file (%s).\n",CONFIG_Filename)
        if exist(CONFIG_Filename,"file")
            fid = fopen(CONFIG_Filename,'r');
            str_JSON = fread(fid);
            str_JSON = char(str_JSON');
            CONFIG = jsondecode(str_JSON);
        else
            error("missing configuration file (%s).\n",CONFIG_Filename);
        end
    end
    if ~isfield(CONFIG,'token')
        CONFIG = [];
        error("No token provided.");        
    end
    if ~isfield(CONFIG,'endpoint')
        CONFIG = [];
        error("No endpoint provided.");
    end

    if ~exist(CONFIG_Filename,"file")
        fid = fopen(CONFIG_Filename,'w');
        str_jsonCONF  = jsonencode(CONFIG);
        fprintf(fid,'%s',str_jsonCONF);
        fclose(fid);
        fprintf("writing the configuration file (%s).\n",CONFIG_Filename)
    end
    %
    if nargout
        out_CONFIG = CONFIG;
    end

end

