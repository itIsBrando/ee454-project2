% Calculation of door, person, camera height
clear;clc;clf;
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

% Calculation of the top of the door
pts1 = pickPoints(2, im1, 'Image 1 Click 2 Points of the door');
pts2 = pickPoints(2, im2, 'Image 2 Click 2 Points on the door');

% Height of the door
out = triangulate(pts1, pts2);
p1 = out(:, 1);
p2 = out(:, 2);
diff = (p1 - p2) / 1000;
fprintf('Height of the door is %f meters.\n', abs(diff(3)));

% Person
imshow(im2);
pts1 = pickPoints(2, im1, 'Image 1 Click Top of the head and the floor');
pts2 = pickPoints(2, im2, 'Image 2 Click Top of the head and the floor');
out = triangulate(pts1, pts2);
p1 = out(:, 1);
p2 = out(:, 2);
diff = (p1 - p2) / 1000; % convert mm to m
fprintf('Heigh of the person is %f meters.\n', abs(diff(3)));

% Center of camera
pts1 = pickPoints(1, im1, 'Image 1 Click center of the camera');
pts2 = pickPoints(1, im2, 'Image 2 Click center of the camera');
out = triangulate(pts1, pts2) / 1000;
fprintf('The center of the camera in 3D is (%f, %f, %f)\n\n', out(1), out(2), out(3));


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