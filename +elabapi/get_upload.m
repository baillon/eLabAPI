function output = get_upload(item_ID)
    % Get an uploaded file from item_ID
    %
    %% Description:
    % This function is part of eLabAPI and downloads uploaded file from its item_ID.
    %
    %% Syntax:
    %   get_upload(item_ID)
    %
    %% Input:
    %   item_ID [integer]:  id of the file to upload
    %
    %% Output: optional
    %   output [struct]:  message from the curl command
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
    [output_str,exitflag] = elabapi.send_req('uploads', item_ID);
    if ~exitflag
        fprintf(2,"Error during upload!");
    end

    if nargout
        output = output_str;
    end
    fprintf('\n\t upload file: upload_%s\n',string(item_ID));
end
