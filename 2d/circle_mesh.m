p = 1;



k_func = (@(x,y) 1);
b_func = (@(x,y) 1);
f_func = (@(x,y) sin(x*y*2*pi));

%boundary condition
boundary_func = (@(t) 0);
dirichletNodes = [];

if boundary_func(0)-boundary_func(2*pi)>1e-6
    disp("Warning: boundary function may not be 2-pi periodic")
end

%circle domain
radius = 1;
center_x = 0; center_y = 0;

%mesh precision
r_prec = radius/20; theta_prec = 2*pi/60;

x = []; y = [];

for r = 1:20
    for theta = 1:60
        x = [x (r*r_prec)*cos(theta*theta_prec)];
        y = [y (r*r_prec)*sin(theta*theta_prec)];     
    end
end
x = [center_x x]; y = [center_y y];

T=delaunay(x,y);
MESH = triangulation(T,x(:),y(:));
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
triplot(MESH);

dirichletNodes = convhull(MESH.Points);
dirichletValues = zeros(length(dirichletNodes),1);

for i = 1:length(dirichletNodes)
    dirichletValues(i,1) = boundary_func(cart2pol(MESH.Points(dirichletNodes(i),1),MESH.Points(dirichletNodes(i),2)));
end

boundaryValues = containers.Map({'Dirichlet','Neumann'},{dirichletValues,[]});
boundaryNodes = containers.Map({'Dirichlet','Neumann'},{dirichletNodes,[]});



        