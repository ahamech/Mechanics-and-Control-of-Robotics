
# 🧰 Kinematics Toolbox for DH Modeling

This folder contains a lightweight, modular MATLAB toolbox for generating forward kinematic transformations and computing the Jacobian matrix using the standard Denavit–Hartenberg (DH) convention.

## ⚙️ Overview

Using this toolbox, you can:
- Define a symbolic or numeric DH table
- Automatically compute all transformation matrices:
  - \( T_i^{i-1} \)
  - \( T_0^i \)
- Compute the end-effector Jacobian (linear and angular parts)
- Extract symbolic expressions for singular configurations

---

## 📁 Files Included

| File                     | Description |
|--------------------------|-------------|
| `generate_dh_table.m`    | User-defined function to provide the DH table; supports both symbolic and numeric modes. |
| `parse_dh.m`             | Parses the DH table into structured form and separates symbolic/numeric parameters. |
| `compute_dh_transform.m` | Computes a single 4x4 homogeneous transformation matrix from DH parameters. |
| `print_dh_transforms.mlx`| Live script that computes and displays all \( T_i^{i-1} \) and \( T_0^i \) matrices. |
| `compute_jacobian.mlx`   | Live script that computes the Jacobian matrix and detects singularities. |

---

## 🚀 How to Use

### 1. Open `generate_dh_table.m`

> ℹ️ **Note:** If you do not plan to use numeric values, you can safely remove the entire `case "numeric"` block from the `generate_dh_table.m` file and keep only the `symbolic` mode.
This is where you define the DH parameters of your robot.

- To use symbolic parameters (e.g., `theta1`, `d3`), set:
  ```matlab
  mode = "symbolic";
  ```
- To use fixed numeric values, set:
  ```matlab
  mode = "numeric";
  ```

Inside this file, each link’s parameters are defined using the standard DH format:
```matlab
% [alpha_i, theta_i, a_i, d_i]
```

Example symbolic row:
```matlab
0, 'theta2', 'l1', 0
```

Example numeric row:
```matlab
0, theta2, 0.4, 0
```

---

### 2. Run the Analysis Scripts

Once the DH table is defined, run the following live scripts:

- 🧮 **`print_dh_transforms.mlx`**  
  Computes and prints all transformation matrices between frames.

- 📊 **`compute_jacobian.mlx`**  
  Computes:
  - End-effector position vector  
  - Linear and angular parts of the Jacobian  
  - Symbolic expression of singularity conditions

> ⚠️ Make sure `mode` is set correctly in `generate_dh_table.m` before running these.

---

## 📁 File Format Notes

Each main script in this toolbox is available in two formats:

- `.m` – Plain-text MATLAB script  
  → Recommended for quick viewing and code referencing on GitHub

- `.mlx` – MATLAB Live Script  
  → Recommended for running interactively in MATLAB or MATLAB Online

> ℹ️ If you don’t have MATLAB installed, consider viewing the `.m` files or checking exported `.pdf` versions (if available).

---

## 📦 Requirements

- MATLAB R2020 or newer (recommended)
- Symbolic Math Toolbox (for symbolic mode)

---

## ✉️ Contact

Created by **Amir Hossein Akbari**  
📧 ahamech@outlook.com
