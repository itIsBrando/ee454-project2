clear;clc;clf;
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

imshow(im1);
title('Image 1 Click 3 Points on the Wall');

hold on;

pts1 = zeros(3, 2);
pts2 = zeros(3, 2);

for i=1:3
    [pts1(i, 1), pts1(i, 2)] = ginput(1);
    plot(pts1(:, 1), pts1(:, 2), 'ro', 'MarkerSize', 15);
end
hold off;

% Do Image 2
imshow(im2);
title('Image 2 Click 3 Points on the Wall');

hold on;
for i=1:3
    [pts2(i, 1), pts2(i, 2)] = ginput(1);
    plot(pts2(:, 1), pts2(:, 2), 'ro', 'MarkerSize', 15);
end

hold off;


% Part B
disp('3D points on Wall:');
plane_points = triangulate(pts1, pts2);
disp(plane_points);

p1 = plane_points(:, 1);
p2 = plane_points(:, 2);
p3 = plane_points(:, 3);

% Calculate the plane
v1 = p2 - p1;
v2 = p3 - p1;
normal_v = cross(v1, v2);
normal_v = normal_v / norm(normal_v);


d = -dot(p1, normal_v);
normal_v
d
fprintf('Equation of the plane %fx + %fy + %fz + %f = 0\n', normal_v(1), normal_v(2), normal_v(3), d);