%% 📌 Compute Jacobian Matrix from DH Table (Symbolic or Numeric)
clc; clear;

%% ⚙️ Mode: 'symbolic' or 'numeric'
mode = "symbolic";  % Change to "numeric" if using fixed values

%% 📥 Load DH Table and Compute Transforms
DH = generate_dh_table(mode);
[DOF, DH_struct, ~, ~] = parse_dh(DH);

Ti_im1 = cell(1, DOF);
Ti_0   = cell(1, DOF);
z_axis = sym(zeros(3, DOF));
o_pos  = sym(zeros(3, DOF));

for i = 1:DOF
    params = [DH_struct(i).param{:}];
    row_struct = struct('alpha', params(1), 'theta', params(2), 'a', params(3), 'd', params(4));
    Ti_im1{i} = compute_dh_transform(row_struct);
    if i == 1
        Ti_0{i} = Ti_im1{i};
    else
        Ti_0{i} = simplify(Ti_0{i-1} * Ti_im1{i});
    end
end

%% 🧭 Compute End-Effector Position Vector
p_ee = Ti_0{DOF}(1:3, 4);

%% 🔧 Extract Joint Variables from DH for symbolic Jacobian
joint_vars = [];
for i = 1:DOF
    theta = DH_struct(i).param{2};
    d     = DH_struct(i).param{4};
    if contains(char(theta), 'theta')
        joint_vars = [joint_vars; theta];
    elseif contains(char(d), 'd')
        joint_vars = [joint_vars; d];
    end
end

%% 📊 Compute Linear Part of Jacobian
Jv = jacobian(p_ee, joint_vars);

%% 🧮 Compute Angular Part of Jacobian
z_axis(:,1) = [0;0;1];
o_pos(:,1) = [0;0;0];
for i = 2:DOF
    z_axis(:,i) = Ti_0{i-1}(1:3,3);
    o_pos(:,i)  = Ti_0{i-1}(1:3,4);
end

Jw = sym(zeros(3, length(joint_vars)));
for i = 1:length(joint_vars)
    if contains(char(joint_vars(i)), 'theta')
        Jw(:,i) = z_axis(:,i);
    else
        Jw(:,i) = [0;0;0];
    end
end

%% 📦 Full Jacobian Matrix
J = simplify([Jv; Jw]);

%% 🖨 Display

p_ee = simplify(p_ee);
Jv   = simplify(Jv);
Jw   = simplify(Jw);
J    = simplify(J);

% Display each one as a standalone output in Live Editor
p_ee   % End-effector position
Jv     % Linear Jacobian
Jw     % Angular Jacobian
J      % Full Jacobian

%% 🚨 Detect Singularities
sing_expr = simplify(det(Jv * transpose(Jv)));
sing_expr  % Expression for singular configurations
