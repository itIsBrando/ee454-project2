% Calculation of door, person, camera height
clear;clc;clf;
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

pts1 = pickPoints(2, im1, 'Image 1 Click 2 Points of the door');
pts2 = pickPoints(2, im2, 'Image 2 Click 2 Points on the door');

% Do Image 2
imshow(im2);
title('Image 2 Click 2 Points on the Door');
pts = pickPoints(2);

hold off;

% Part B
out = triangulate(pts1, pts2);

p1 = out(:, 1);
p2 = out(:, 2);
diff = p1 - p2;
fprintf('Height of the door is %f meters.', diff);


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