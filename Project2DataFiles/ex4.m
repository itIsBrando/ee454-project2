clear;clc;clf;
cam1 = load('Parameters_V1.mat').Parameters;
cam2 = load('Parameters_V2.mat').Parameters;


% R2 * R1T
R = cam2.Rmat * cam1.Rmat';

T = (cam2.position - cam1.position);


S = [0 -T(3) T(2); T(3) 0 -T(1); -T(2) T(1) 0];

E = R * S;
F = cam1.Kmat * E;