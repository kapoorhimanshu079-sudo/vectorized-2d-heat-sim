% 2D Transient Heat Conduction Simulator (Vectorized + Insulated Boundaries)
clear; clc; close all;

% 1. Geometry and Grid Setup
L = 1.0; W = 1.0;
Nx = 60; Ny = 60;          
dx = L / (Nx - 1); dy = W / (Ny - 1);

% 2. Material Properties
alpha = 1.11e-4;  

% 3. Stability & Time Setup
dt = (dx^2) / (4 * alpha) * 0.95; 
t_final = 300;    
Nt = ceil(t_final / dt);

% 4. Initialize Temperature Matrix
T = 20 * ones(Ny, Nx); 

% Apply Constant Top/Bottom Boundaries (Dirichlet)
T(1, :) = 100;    % Top edge hot plate (100°C)
T(end, :) = 0;    % Bottom edge cold plate (0°C)
% Left and right boundaries are initially 20°C but will evolve freely!

figure('Position', [100, 100, 800, 600]);

% 5. Time-Stepping Loop
for n = 1:Nt
    T_old = T; 
    
    %% A. Update Internal Nodes (Vectorized)
    d2T_dx2 = (T_old(2:end-1, 3:end) - 2*T_old(2:end-1, 2:end-1) + T_old(2:end-1, 1:end-2)) / dx^2;
    d2T_dy2 = (T_old(3:end, 2:end-1) - 2*T_old(2:end-1, 2:end-1) + T_old(1:end-2, 2:end-1)) / dy^2;
    T(2:end-1, 2:end-1) = T_old(2:end-1, 2:end-1) + alpha * dt * (d2T_dx2 + d2T_dy2);
    
    %% B. Update Insulated Left Boundary (j = 1) using Ghost Nodes
    d2T_dx2_left = 2 * (T_old(2:end-1, 2) - T_old(2:end-1, 1)) / dx^2;
    d2T_dy2_left = (T_old(3:end, 1) - 2*T_old(2:end-1, 1) + T_old(1:end-2, 1)) / dy^2;
    T(2:end-1, 1) = T_old(2:end-1, 1) + alpha * dt * (d2T_dx2_left + d2T_dy2_left);
    
    %% C. Update Insulated Right Boundary (j = Nx) using Ghost Nodes
    d2T_dx2_right = 2 * (T_old(2:end-1, end-1) - T_old(2:end-1, end)) / dx^2;
    d2T_dy2_right = (T_old(3:end, end) - 2*T_old(2:end-1, end) + T_old(1:end-2, end)) / dy^2;
    T(2:end-1, end) = T_old(2:end-1, end) + alpha * dt * (d2T_dx2_right + d2T_dy2_right);
    
    %% 6. Visualization (Animate every 10 time steps)
    if mod(n, 10) == 0 || n == Nt
        imagesc([0 L], [0 W], T);
        colormap('hot'); colorbar; caxis([0 100]);
        xlabel('Width X (m)'); ylabel('Height Y (m)');
        title(sprintf('Insulated Sides 2D Heat Diffusion | Time: %.2f / %d s', n*dt, t_final));
        drawnow; 
    end
end