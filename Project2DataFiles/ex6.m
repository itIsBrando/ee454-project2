clear;clc;
load('F.mat');

% this is the F matrix generated from the 8pt algorithim,
F8pt=[0.00116817 0.00608009   -1.81722; 0.00623467 -0.0187869    14.8623; -2.61656   -13.8736    4192.57];

fprintf('SED for Task 4 F Matrix: %f\n', SED(F));
fprintf('SED for Task 5 8pt F Matrix: %f\n', SED(F8pt));


function avg_dist = SED(F)
    dist = 0;
    load('projection1.mat');
    load('projection2.mat');
    for i=1:size(p1,2)
        % Convert point to homogeneous coordinates
        c1 = [p1(i, :)'; 1];
        c2 = [p2(i,:)'; 1];
    
        lineL = F*c1;
        lineR = F'*c2;
    
        dL = dot(lineL, c1)^2/(lineL(1) ^ 2 + lineL(2)^2);
        dR = dot(lineR, c2)^2/(lineR(1) ^ 2 + lineR(2)^2);
        dist = dist + dL + dR;
    end

    avg_dist = dist / (size(p1, 2) * 2);
end