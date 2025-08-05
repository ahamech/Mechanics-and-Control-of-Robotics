function T = compute_dh_transform(DH_row)
% COMPUTE_DH_TRANSFORM Computes the standard Denavit-Hartenberg transformation matrix.
%
% Input:
%   DH_row - Struct with fields: alpha, theta, a, d
%            Each field can be symbolic or numeric.
%
% Output:
%   T - 4x4 homogeneous transformation matrix

    alpha = DH_row.alpha;
    theta = DH_row.theta;
    a     = DH_row.a;
    d     = DH_row.d;

    T = [ cos(theta), -sin(theta),  0,           a;
          sin(theta)*cos(alpha),  cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
          sin(theta)*sin(alpha),  cos(theta)*sin(alpha),  cos(alpha),  cos(alpha)*d;
          0,           0,           0,           1 ];

    T = simplify(T);
end
