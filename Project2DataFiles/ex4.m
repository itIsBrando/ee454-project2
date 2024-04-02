clear;clc;clf;
cam1 = load('Parameters_V1.mat').Parameters;
cam2 = load('Parameters_V2.mat').Parameters;

im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

R1 = cam1.Rmat;
R2 = cam2.Rmat;
t1 = cam1.position';
t2 = cam2.position';

% R2 * R1T
R = R1' * R2;

T = R1' * (t2 - t1);
% T = cam2.position - cam1.position;

S = [0   -T(3) T(2);
     T(3)  0  -T(1);
    -T(2) T(1)  0];

E = R * S;

% F = Kr^(-T) * E * Kl^-1
F = inv(cam2.Kmat)' * E * inv(cam1.Kmat);
F
%[0.00116817 0.00608009   -1.81722; 0.00623467 -0.0187869    14.8623; -2.61656   -13.8736    4192.57]

save('F.mat', "F");

pts1 = pickPoints(1, im1, 'Image1 Epipolar Lines');
pts2 = pickPoints(1, im2, 'Image2 Epipolar Lines');

% find epipolar right line.
line = F * [pts1'; 1];
 
% Attempting to draw epipolar lines
[h, w] = size(im1);
x_range = linspace(0, w, w);
% ax+by+c=0 -> y = -(ax+c) / b
y_range = -(line(1) * x_range + line(3)) / line(2);

% Plots epipole
hold on;
plot(x_range, y_range, 'r', 'LineWidth', 2);

hold off;


function pts = pickPoints(n, im, name)
    pts = zeros(n, 2);
    imshow(im);
    title(name);
    hold on;
    for i=1:n
        [pts(i, 1), pts(i, 2)] = ginput(1);
        plot(pts(:, 1), pts(:, 2), 'ro', 'MarkerSize', 15);
    end
    hold off;
end