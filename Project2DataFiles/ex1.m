clear;clc;clf;
cam1 = load('Parameters_V1.mat').Parameters;
cam2 = load('Parameters_V2.mat').Parameters;

[px1, py1] = projection(cam1);
[px2, py2] = projection(cam2);
p1 = [px1 py1];
p2 = [px2 py2];

save('projection1', 'p1');
save('projection2', 'p2');

figure(1);
imagesc(imread('im1corrected.jpg'));
hold on;

plot(px1, py1, 'ro', 'MarkerSize', 2, 'LineWidth', 2);
hold off;

% Create the second image
figure(2);
imagesc(imread('im2corrected.jpg'));
hold on;
plot(px2, py2, 'ro', 'MarkerSize', 2, 'LineWidth', 2);
hold off;


function [points_x, points_y] = projection(cam)
    mocap = load('mocapPoints3D.mat');
    points_3d = mocap.pts3D;
    num_points = size(points_3d, 2);
    points_x = zeros(num_points, 1);
    points_y = zeros(num_points, 1);
    
    % Do image 1 pixel calculations
    for i = 1:num_points
        % make world coordinate 1x4
        world_coordinate = [points_3d(:, i); 1];
        % get x, y, z translation
        pos_x = -cam.position(1); pos_y = -cam.position(2); pos_z = -cam.position(3);
    
        % Offset Matrix 4x4
        S = [1 0 0 pos_x; 0 1 0 pos_y; 0 0 1 pos_z; 0 0 0 1];
        
        % rotation Matrix 4x4
        R = [cam.Rmat, zeros(3,1); zeros(1, 3), 1];
    
        % Calculate cam coordinate
        camera_coordinate = R * S * world_coordinate;
        
        % pixel coordinate
        pt = cam.Kmat * camera_coordinate(1:3); % make cam coordinate from 1x4 to 1x3
        pt = pt / pt(3); % projection
        
        % add these points to an array of x and y coordinates
        points_x(i) = pt(1);
        points_y(i) = pt(2);
    end
end