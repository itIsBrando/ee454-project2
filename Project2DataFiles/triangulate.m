function out = triangulate(p1, p2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    sizeP1 = size(p1, 1);
    out = zeros(3, sizeP1(1));
    cam1 = load('Parameters_V1.mat').Parameters;
    cam2 = load('Parameters_V2.mat').Parameters;

    for i=1:size(p1, 1)
        % Pw=c+lambda*v
        T1 = cam1.Rmat * cam1.position'*-1; % maybe wrong
        % c = -R' * T
        c1 = -1*cam1.Rmat'*T1;
        v1 = cam1.Rmat' * inv(cam1.Kmat) * [p1(i, :)'; 1];

        T2 = cam2.Rmat*cam2.position'*-1; % maybe wrong
        % c = -R' * T
        c2 = -1*cam2.Rmat'*T2;
        v2 = cam2.Rmat' * inv(cam2.Kmat) * [p2(i, :)'; 1];

        % Find line perpendicular to v1, v2
        v3 = cross(v1, v2);
        v3 = v3 / norm(v3);

        % Solve for unknowns: a, b, d
        coeff = linsolve([v1 -1*v2 v3], c2-c1);
        a = coeff(1); b = coeff(2); d = coeff(3);
        % Left and right line segment
        Ol = a * v1 + c1;
        Or = b * v2 + c2;

        % Calculate mid point
        midpoint =  0.5 * (Ol - Or);
        out(:, i) = Ol + midpoint;
    end
end