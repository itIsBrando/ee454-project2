clear;clc;clf;

mocap = load('mocapPoints3D.mat');
load('projection1.mat');
load('projection2.mat');

pts = triangulate(p1, p2)

fprintf("Mean squared error: %f\n", immse(pts, mocap.pts3D));