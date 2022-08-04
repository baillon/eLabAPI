function output = get_backup_zip(period)
    % Get the backup zip of modified experiments during datespan
    %
    %% Description:
    % This function is part of eLabAPI and downloads a Zip archive
    % containing all the experiments modified in the specified time interval.
    %% Syntax:
    %   get_backup_zip(period)
    %
    %% Input:
    %   period [string]:  datespan in the format uuuuMMdd-uuuMMdd
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
    output_str = elabapi.send_req('backupzip', period);
    if nargout
        output = output_str;
    end
    fprintf('\n\t backup file: backup_%s.zip\n',period);
end
