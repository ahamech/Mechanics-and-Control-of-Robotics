function DH = generate_dh_table(mode)
% Generate_DH_Table Returns the Denavit-Hartenberg table for a 4-DOF SCARA robot.
% 
% Input:
%   mode - (optional) 'symbolic' or 'numeric'. Default is 'symbolic'.
%
% Output:
%   DH - A cell array (Nx4) containing DH parameters:
%        Each row: [alpha, theta, a, d]

    if nargin < 1
        mode = "symbolic";
    end

    switch lower(mode)
        case "symbolic"
            % Symbolic DH table (theta_i and d3 are variables)
            DH = {
                0      'theta1'   0     'l0'; 
                0      'theta2'  'l1'    0; 
                0       0        'l2'   'd3'; 
                0      'theta4'   0      0
            };

        case "numeric"
            % Numeric DH table with symbolic joint variables
            syms theta1 theta2 theta4 d3 real
            DH = {
                0      theta1   0     0.3;   % link 1: d1 = l0
                0      theta2  0.4     0;    % link 2: a1 = l1
                0        0     0.2     d3;   % link 3: a2 = l2
                0      theta4   0      0     % link 4: rotation only
            };

        otherwise
            error('Unsupported mode. Use "symbolic" or "numeric".');
    end
end
