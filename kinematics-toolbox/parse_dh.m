function [DOF, DH_struct, sym_params, numeric_params] = parse_dh(DH)
% PARSE_DH Parses a DH table with support for symbolic, numeric, or string-based parameters.
%
% Input:
%   DH - Nx4 cell array containing DH parameters.
%        Each entry may be a string (for symbolic), double, or sym.
%
% Output:
%   DOF            - Number of degrees of freedom (number of rows)
%   DH_struct      - Struct array containing parsed DH parameters
%   sym_params     - List of symbolic parameters (e.g., theta1, d3)
%   numeric_params - List of numeric values (double or constant sym)

    DOF = size(DH, 1);
    DH_struct = struct();
    sym_params = sym.empty(0,1);
    numeric_params = [];

    for i = 1:DOF
        for j = 1:4
            entry = DH{i,j};

            if ischar(entry) || isstring(entry)
                % Convert string to symbolic variable
                symval = sym(entry, 'real');
                DH_struct(i).param{j} = symval;
                sym_params(end+1,1) = symval;

            elseif isnumeric(entry)
                % Direct numeric value (double)
                DH_struct(i).param{j} = entry;
                numeric_params(end+1,1) = entry;

            elseif isa(entry, 'sym')
                % Direct symbolic value
                DH_struct(i).param{j} = entry;
                if isempty(symvar(entry))
                    % Constant symbolic number (e.g., sym(0.2))
                    numeric_params(end+1,1) = entry;
                else
                    % Variable symbolic parameter (e.g., theta1)
                    sym_params(end+1,1) = entry;
                end

            else
                error('Invalid DH entry at (%d,%d)', i, j);
            end
        end
    end
end
