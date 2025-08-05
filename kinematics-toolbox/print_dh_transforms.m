%% 🔄 Print DH Transformations (Symbolic or Numeric)
clc; clear;

%% 🌐 Select Mode: symbolic or numeric
mode = "symbolic";  % Change to "numeric" if you want numerical parameters

%% 📥 Load and parse DH table
DH = generate_dh_table(mode);
[DOF, DH_struct, ~, ~] = parse_dh(DH);

%% 🔧 Compute all T_i^{i-1}
Ti_im1 = cell(1, DOF);
for i = 1:DOF
    params = [DH_struct(i).param{:}];
    row_struct = struct('alpha', params(1), 'theta', params(2), ...
                        'a',     params(3), 'd',     params(4));
    Ti_im1{i} = compute_dh_transform(row_struct);
end

%% 🔁 Compute T_0^i recursively
Ti_0 = cell(1, DOF);
Ti_0{1} = Ti_im1{1};
for i = 2:DOF
    Ti_0{i} = simplify(Ti_0{i-1} * Ti_im1{i});
end

%% 🖨 Display matrices as numbered symbolic outputs
for i = 1:DOF
    fprintf('--- T_%d_%d ---\n', i, i-1);
    eval(sprintf('T_%d_%d = vpa(Ti_im1{%d}, 4)', i, i-1, i));
end

for i = 1:DOF
    fprintf('--- T_0_%d ---\n', i);
    eval(sprintf('T_0_%d = vpa(Ti_0{%d}, 4)', i, i));
end
