# Linear Acoustic Wave Equations Solver

## Development and Contribution
* Author: **Jaeyong Jeong** (jaeyong.jeong@postech.ac.kr)
* Organization: FPE, POSTECH (http://fpe.postech.ac.kr)
* License: GPL-3.0
---

## Introduction

This program is written by Matlab. The code solves the time-domain acoustic wave equations in 1D or 2D free space as below:

$$\frac{\partial u_x}{\partial t}+\frac{1}{\rho}\frac{\partial p}{\partial x}=0 $$
$$\frac{\partial u_y}{\partial t}+\frac{1}{\rho}\frac{\partial p}{\partial y}=0 $$
$$\frac{\partial p}{\partial t}+\rho c^2 \left( \frac{\partial u_x}{\partial x}+\frac{\partial u_y}{\partial y}\right)=S $$

where, $\rho$ is density, $c$ is speed of sound, $u_x, u_y$ is acoustic velocity, $p$ is acoustic pressure, and $S$ is source distribution.

---

## Algorithm

4th order Runge-Kutta method is used for the time integration. For spatial discretization, 6th order compact finite difference method is used ([Lele, 1992](https://doi.org/10.1016/0021-9991(92)90324-R) ). The computational domain is set to a square which has 4 boundaries in 2D case. In 1D case, The domain is a finite segment overlapping to X-axis. On the boundaries, non-reflecting buffer zone-type boundary conditions based on grid-stretching and filtering is imposed ([Edgar & Visbal, 2003](https://doi.org/10.2514/6.2003-3300) ). In this method, the buffer zone is attached on the boundaries and a 10th order high pass spatial filter is applied at the end of every time step. Refer to ([Seo & Moon, 2006](https://doi.org/10.1016/j.jcp.2006.03.003) ).

---

## How to use

At first, you need to edit the Config.m. Users can specify the configuration of the simulation just by editing the Config.m. After that, run the Matlab (ver>2014b). In the command line, type this: 
> run_jlaws

It will takes some time, which depends on the performance of your machine or your case. After the simulation is completed, you may want to visualize the result. Basically this program support the visualization of 2D solution field at the timeStep. The program save the result data in the pre-specified directory. visualizedData_2D.m and visualizeData1D can visualize the saved data. In the command line, type like this:
> p=visualizeData_2D(conf,nStep);

or
> p=visualizeData_1D(conf,nStep);

Here, nStep means the order of the result data file in the directory. If the target result file is 10th, then nStep is set to 10.
The output, p, is the loaded solution field in the file.

----
## Input perturbation and source

As an input, you can specify the waveform of the perturbation and source. This program supply some input: Gaussian point pulse, Gaussian line pulse, Gaussian source, and sinusoidal line pulse.

### 1. Gaussian point pulse: 

$$p(x,y,t=0) = exp \Big( -ln(2)\frac{(x-x_s)^2+(y-y_s)^2}{\sigma^2} \Big)$$

### 2. Gaussian line pulse: 

$$p(x,t=0) = exp \Big( -ln(2)\frac{(x-x_s)^2}{\sigma^2} \Big)$$

### 3. Gaussian source:

$$S(x,y,t) = exp \Big( -ln(2)\frac{(x-x_s)^2+(y-y_s)^2}{\sigma^2} \Big)sin(\omega t)$$

### 4. Sinusoidal line pulse:

$$ p(\eta) = \left\{ \begin{array}{ll}
sin(\omega_c \eta)-0.5sin(2\omega_c \eta) & \textrm{if 0< $\eta<\frac{2\pi}{\omega_c}$}\\
0 & \textrm{else}
\end{array} \right.
$$
$$p(\eta) \in C^2$$
$$\eta = t-x/c $$
$$\omega_c = \frac{2\pi}{t_0}$$

### 5. User-defined pulse


If you want another input waveform, modify **imposeIC.m**

---
## Config.m

### rho
- density of the medium
### c
- speed of the wave 
### deltaT
- time step size
- CFL=c*deltaT/deltaX should be less than 1.
- Low CFL can make the simulation stable.
### timeLimit
- The total simulation time
### deltaX, deltaY
- Grid spacing of X and Y
### innerPtX, innerPtY
- The number of grid points along the X and Y
- Total number of grid points in the domain is innerPtX*innerPtY
### expRatio
- The grid stretching ratio in the buffer zone.
- expRatio=2 is recommended.
### bufferPt
- The number of layers in the buffer zone
- bufferPt=10~12 is recommended.
### filterAlpha
- The free parameter in the spatial low pass filter
- $-0.5<\alpha<0.5$
- As alpha increase, the spectrum of the transfer function become more steep, and cutoff wavenumber increase.
- The filter suppresses the high wave components and makes the numerical scheme more dissipative and stable.
- filteralpha=0.45 is recommended.
### writingInterval
- The interval of the result data
- If writingInterval=10, then the program write the result data every 10 steps
### gridType
- Just maintain gridType=1
### resultDir
- The relative path of the directory in which the result data of the case is saved.
### dim
- Dimension
- For 1D case, dim=1
- For 2D case, dim=2
### inputPulseType
- The type of input pulse or source
- If inputPulseType=1, Gaussian point pulse
- If inputPulseType=2, Gaussian line pulse
- If inputPulseType=3, Gaussian source
- If inputPulseType=4, Sinusoidal line pulse
- If you want user-specified input pulse or source, modify the file imposeIC.m
### sigma
- When inputPulseType=1,2, or 3, this parameter is a sigma of Gaussian function.
### freq
- When inputPulseType=3, this parameter is the frequency of the source distribution, $\omega=2 \pi (freq)$.
### x0, y0
- When inputPulseType=1,2, or 3, this parameter is the center of the pulse.
### initialT0
- When inputPulseType=4, $$\omega_c=\frac{2\pi}{T_0}$$
- In this case, the initial time is not 0, but initialT0
---