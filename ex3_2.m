clear;clc;clf;

load('projection1.mat');
load('projection2.mat');

pts = triangulate(p1, p2)