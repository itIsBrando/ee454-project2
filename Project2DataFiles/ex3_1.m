clear;clc;clf;
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

imshow(im1);
title('Image 1 Click 3 Points on the Floor');

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
title('Image 2 Click 3 Points on the Floor');

hold on;
for i=1:3
    [pts2(i, 1), pts2(i, 2)] = ginput(1);
    plot(pts2(:, 1), pts2(:, 2), 'ro', 'MarkerSize', 15);
end

hold off;


% Part A
disp('3D points on floor:');
disp(triangulate(pts1, pts2));