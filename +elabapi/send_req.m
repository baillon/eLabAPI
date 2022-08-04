function [output, exitflag] = send_req(endpoint_key,params,send_mode)
    % Send the request to the api endpoint.
    % 
    %% Description:
    % This function is part of eLabAPI and sends the request to the api endpoint. 
    %   
    %% Syntax:
    %   send_req(endpoint_key,params,send_mode))
    % or
    %   [RESULT, exitFlag] = send_req(endpoint_key,params,send_mode)
    %
    %% Input:
    %   endpoint_key [string]:  address end to the eLabFTW API,
    %       endpoint_key{'items','experiments','items_types','status','tags','templates','bookable','backupzip','uploads'}
    %   params [struct]:  parameters for the request
    %   send_mode [string]:  type of request
    %       send_mode{'default','add','update','upload'}
    %
    %% Output: optional
    %   RESULT [struct]:  structure with output of the reques
    %   exitFlag [boolean]:  logical value (true or false) to indicate if
    %           the send request is OK.
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

    if nargin<2
        params=[];
    end
    if nargin<3
        send_mode = 'default';
    end
    [strCommand,optionsEcho] = set_CurlCommand(endpoint_key,params,send_mode);
    [status,output] = system(strCommand,optionsEcho);
    exitflag = ~status;
end
    
    
    
    
%% Sub-function to create the Curl command    
function [strCommand,strOptionsEcho] = set_CurlCommand(endpoint_key,params,send_mode)
    persistent CURL_path CONFIG
    
    % la structure CONFIG contient les éléments de configuration pour
    % l'accès à l'api d'elabFTW
    if isempty(CONFIG)
        initCONFIG = elabapi.init();
        if ~isempty(initCONFIG)
            CONFIG = initCONFIG;
        end
    end
    
    % path to the curl binary of the system
    if isempty(CURL_path)
        [status,CURL_path] = system('which curl');
        CURL_path = sprintf('LD_LIBRARY_PATH="" && %s',CURL_path);
        if status
            error("curl not found!")
        else
            CURL_path = CURL_path(1:end-1);
        end
    end
    if isfield(CONFIG,'verify')  && ~CONFIG.verify
        CURL_path = sprintf('%s -k',CURL_path);
    end
    %
    switch lower(send_mode)
        case 'default'
            CURL_mode = '';
        case 'add'
            CURL_mode = '-X POST -F "#VALUE#"';
        case {'update','upload'}
            CURL_mode = '-X POST #VALUE#';
        case 'create'
            CURL_mode = '-X POST ';
        case 'delete'
            CURL_mode = '-X DELETE ';
        otherwise
            CURL_mode = '';
    end
    %
    strCommand = sprintf('%s %s -H "Authorization: %s" %s',CURL_path, CURL_mode, CONFIG.token, CONFIG.endpoint);
    strKey = lower(endpoint_key);
    curl_options = [];
    strOptionsEcho ='';
    switch strKey
        %
        case {'items','experiments','events'}
            item_id ='';
            if isstruct(params)
                field_Names = fieldnames(params);
                cell_params = {};
                % 
                switch lower(send_mode)
                    case {'update'}
                        for iF = 1:numel(field_Names)
                            curfield = field_Names{iF};
                            switch curfield
                                case 'id'
                                    item_id = string(params.id);
                                otherwise
                                    cell_params{end+1} = sprintf('%s=%s',curfield,string(params.(curfield))); %#ok<AGROW>
                            end
                        end
                    case 'upload'
                        for iF = 1:numel(field_Names)
                            curfield = field_Names{iF};
                            switch curfield
                                case 'id'
                                    item_id = string(params.id);
                                case 'file'
                                    cell_params{end+1} = sprintf('file=@%s',string(params.(curfield))); %#ok<AGROW>
                            end
                        end
                        %
                    otherwise
                        for iF = 1:numel(field_Names)
                            curfield = field_Names{iF};
                            switch curfield
                                case 'id'
                                    item_id = string(params.id);
                                case {'limit','offset','search','tag','link'}
                                    cell_params{end+1} = sprintf('%s=%s',curfield,string(params.(curfield))); %#ok<AGROW>
                            end
                        end
                        %
                end
                %
                %
            elseif isstring(params)
                item_id = params{1};
            elseif isnumeric(params)
                item_id = string(params);
            end
            str_params = strjoin(cell_params,'&');
            if ~isempty(str_params)
                switch send_mode
                    case 'default'
                        strUrl = sprintf('%s/%s?%s',strKey,item_id,str_params);
                    case {'add','update','upload'}
                        strUrl = sprintf('%s/%s',strKey,item_id);
                end
            else
                strUrl = sprintf('%s/%s',strKey,item_id);
            end
            %
        case 'backupzip'
            if isstring(params)
                datespan = params{1};
            elseif ischar(params)
                datespan = params;
            end
            strUrl = sprintf('%s/%s',strKey,datespan);
            curl_options = sprintf(' --output backup_%s.zip',datespan);
            strOptionsEcho ='-echo';
            %
        case 'uploads'
            if isstring(params)
                item_ID = params{1};
            elseif ischar(params)
                item_ID = params;
            elseif isnumeric(params)
                item_ID = string(params);
            end
            strUrl = sprintf('%s/%s',strKey,item_ID);
            curl_options = sprintf(' --output upload_%s',item_ID);
            strOptionsEcho ='-echo';
            %
        case {'items_types','status','tags','templates','bookable'}
            strUrl = sprintf('%s/',strKey);
            %
        otherwise
            error('keyWord (%s) not defined',strKey);
    end
    if isempty(curl_options)
        strCommand = sprintf('%s/"%s"',strCommand,strUrl);
    else
        strCommand = sprintf('%s/"%s" %s',strCommand,strUrl,curl_options);
    end
    switch send_mode
        case 'add'
            strCommand = strrep(strCommand,'#VALUE#',str_params);
        case {'update','upload'}
            str_params = strjoin(strcat('-F "',cell_params,'"'),' ');
            strCommand = strrep(strCommand,'#VALUE#',str_params);
    end
end
