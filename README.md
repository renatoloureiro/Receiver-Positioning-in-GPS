# Receiver Positioning in GPS

<p>
    <img src="https://img.shields.io/badge/ubuntu-v20.04-blue"/>
    <img src="https://img.shields.io/badge/matlab-R2020a-orange"/>
    <img src="https://img.shields.io/badge/language-portuguese-red"/>
</p>

Project for the course "Air Traffic Control Systems" at Instituto Superior Técnico.

The project consists of implementing a simulator of an aircraft trajectory with the
following major tasks:
- Generation of a GPS satellite constellation with the use of almanacs obtained in [Celestrak](https://celestrak.com/)
- Determination of the satellites in view from a selected location on the Earth surface.
- Determination of the optimum sub-constellation for a certain number of satellites N selectable  using minimization of the PDOP parameter.
- Implementation of the least-squares and extended Kalman filter (EKF) algorithms (models PV and/or PVA) using the pseudoranges with imperfect ionospheric/tropospheric corrections as observations.
- Estimation of the receiver’s position (latitude, longitude, and altitude), velocity (and acceleration for PVA model) using the least-squares and the EKF.

## Results



<p float="left">
  <img src="/Images/fig40.png" width="300" />
  <img src="/Images/fig44.png" width="300" />
  <img src="/Images/fig19.png" width="300" />
  <img src="/Images/fig42.png" width="300" /> 
</p>