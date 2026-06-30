# Vectorized 2D Transient Heat Diffusion Simulator

A high-performance MATLAB simulator that models time-dependent heat conduction across a two-dimensional thin plate using the Finite Difference Method (FDM). The simulation incorporates advanced programming practices via vectorization and models real-world physics using a combination of Dirichlet (constant temperature) and Neumann (insulated/zero-flux) boundary conditions.

## Mathematical Framework

The simulator solves the 2D transient heat equation:

$$\frac{\partial T}{\partial t} = \alpha \left(\frac{\partial^2 T}{\partial x^2} + \frac{\partial^2 T}{\partial y^2}\right)$$

Where:

- $T$ = Temperature ($^\circ\text{C}$)
- $t$ = Time ($\text{s}$)
- $\alpha$ = Thermal diffusivity ($\text{m}^2/\text{s}$), configured here for Copper ($\alpha = 1.11 \times 10^{-4} \text{ m}^2/\text{s}$)
- $x, y$ = Spatial coordinates ($\text{m}$)

### Numerical Scheme & Stability

The spatial derivatives are discretized using a second-order Central Difference scheme, while the time derivative uses a Forward Euler approach (FTCS explicit scheme). To ensure the stability of the numerical solution and prevent numerical explosion, the time step ($\Delta t$) strictly adheres to the Courant-Friedrichs-Lewy (CFL) stability criterion:

$$\Delta t \le \frac{\Delta x^2}{4\alpha} \quad \text{(assuming } \Delta x = \Delta y\text{)}$$

---

## Key Features

- **High-Performance Vectorization:** Replaced traditional, slow nested `for` loops with optimized matrix slicing. Spatial derivatives are computed simultaneously across the entire internal matrix grid, eliminating interpreter overhead and reducing computation time by orders of magnitude.
- **Insulated Boundaries (Ghost Nodes):** The left and right walls simulate perfect thermal insulation ($\frac{\partial T}{\partial x} = 0$). This Neumann boundary condition is achieved dynamically using fictitious "ghost nodes" outside the physical boundary, forcing the heat front to remain perpendicular to the walls.
- **Real-time Live Visualization:** Utilizing MATLAB's `imagesc` and `drawnow` engine to render a live thermal map animation as heat flows from the hot source to the steady-state gradient.

---

## Boundary Conditions

- **Top Boundary (Dirichlet):** Maintained at a constant $100^\circ\text{C}$ (Constant Heat Source).
- **Bottom Boundary (Dirichlet):** Maintained at a constant $0^\circ\text{C}$ (Constant Heat Sink).
- **Left & Right Boundaries (Neumann):** Perfectly insulated ($\nabla T \cdot \mathbf{n} = 0$). Evolves dynamically.
- **Initial Plate Condition:** Uniformly initialized at room temperature ($20^\circ\text{C}$).

---

## Getting Started

### Prerequisites

- MATLAB (R2020a or later recommended) OR MATLAB Online access.

### Running the Simulation

1. Clone this repository to your local machine or workspace:
   ```bash
   git clone [https://github.com/kapoorhimanshu079-sudo/vectorized-2d-heat-sim.git](https://github.com/kapoorhimanshu079-sudo/vectorized-2d-heat-sim.git)
   ```
