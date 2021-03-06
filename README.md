# Linear Acoustic Wave Equations Solver

## Development and Contribution
* Author: **Jaeyong Jeong** (jaeyong.jeong@postech.ac.kr)
* Organization: FPE, POSTECH (http://fpe.postech.ac.kr)
* License: GPL-3.0
---

## Introduction

This program is written by Matlab. The code solves the time-domain acoustic wave equations in 1D or 2D free space as below:

<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/cebcc5a2e56ac88c393c3eb9679a0511.svg?invert_in_darkmode" align=middle width=114.82597499999999pt height=36.953894999999996pt/></p>
<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/1a000c0318d83baf239a8b52238c5be0.svg?invert_in_darkmode" align=middle width=113.70546pt height=36.953894999999996pt/></p>
<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/389b058958e52741efdf2b3dd6e2751a.svg?invert_in_darkmode" align=middle width=204.9135pt height=39.30498pt/></p>

where, <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/6dec54c48a0438a5fcde6053bdb9d712.svg?invert_in_darkmode" align=middle width=8.467140000000004pt height=14.102549999999994pt/> is density, <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/3e18a4a28fdee1744e5e3f79d13b9ff6.svg?invert_in_darkmode" align=middle width=7.087278000000003pt height=14.102549999999994pt/> is speed of sound, <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/71159c622b6dd4d9514fa185808a9daa.svg?invert_in_darkmode" align=middle width=41.36847pt height=14.102549999999994pt/> is acoustic velocity, <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/2ec6e630f199f589a2402fdf3e0289d5.svg?invert_in_darkmode" align=middle width=8.239720500000002pt height=14.102549999999994pt/> is acoustic pressure, and <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/e257acd1ccbe7fcb654708f1a866bfe9.svg?invert_in_darkmode" align=middle width=10.986195000000004pt height=22.381919999999983pt/> is source distribution.

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

<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/e606d3f109888fb1b6b88bbed72002e5.svg?invert_in_darkmode" align=middle width=366.29834999999997pt height=35.749725pt/></p>

### 2. Gaussian line pulse: 

<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/753a0487aa26e553c566b98fa3ab6992.svg?invert_in_darkmode" align=middle width=266.31329999999997pt height=35.749725pt/></p>

### 3. Gaussian source:

<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/b42d4ecf904e1b89f66753a8ddcf9d70.svg?invert_in_darkmode" align=middle width=391.611pt height=35.749725pt/></p>

### 4. Sinusoidal line pulse:

<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/1d73eb95ac68670097ed3d33b174aafc.svg?invert_in_darkmode" align=middle width=341.73975pt height=40.01679pt/></p>
<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/949cde19577625b9b80166278fe54444.svg?invert_in_darkmode" align=middle width=69.15777pt height=18.269295pt/></p>
<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/e1f6adfe61b01eed3e434aa3b9ebd1b7.svg?invert_in_darkmode" align=middle width=81.18428999999999pt height=16.376943pt/></p>
<p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/f9ec3bf51e57a83467f085a500a6fde0.svg?invert_in_darkmode" align=middle width=58.912259999999996pt height=35.41626pt/></p>

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
- <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/3b99a2f465b8e49015c67363c21d7ae6.svg?invert_in_darkmode" align=middle width=108.867pt height=21.10812pt/>
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
- When inputPulseType=3, this parameter is the frequency of the source distribution, <img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/84eb4977857799600b62204bd5d23a25.svg?invert_in_darkmode" align=middle width=96.6636pt height=24.56552999999997pt/>.
### x0, y0
- When inputPulseType=1,2, or 3, this parameter is the center of the pulse.
### initialT0
- When inputPulseType=4, <p align="center"><img src="https://rawgit.com/jyjeong0890/j_laws/master/svgs/35749166c09da179631c4e9b75193d97.svg?invert_in_darkmode" align=middle width=58.912259999999996pt height=35.41626pt/></p>
- In this case, the initial time is not 0, but initialT0
---