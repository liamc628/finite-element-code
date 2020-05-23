%boundary conditions
boundary_func = (@(t) sin(2*t));
dirichletNodes = [];

if boundary_func(0)-boundary_func(2*pi)>1e-6
    disp("Warning: boundary function may not be 2-pi periodic")
end

%circle domain
radius = 3;
center_x = 0; center_y = 0;
max_elem_size = 0.05;


gd = [1,center_x,center_y,radius]';
geo = decsg(gd);
model = createpde;
geometryFromEdges(model,geo);
mesh = generateMesh(model,'GeometricOrder','linear','Hmax',max_elem_size);
MESH = triangulation(mesh.Elements',mesh.Nodes(1,:)',mesh.Nodes(2,:)');
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
%triplot(MESH);

dirichletNodes = convhull(MESH.Points);
dirichletValues = zeros(length(dirichletNodes),1);

for i = 1:length(dirichletNodes)
    dirichletValues(i,1) = boundary_func(cart2pol(MESH.Points(dirichletNodes(i),1),MESH.Points(dirichletNodes(i),2)));
end

boundaryValues = containers.Map({'Dirichlet','Neumann'},{dirichletValues,[]});
boundaryNodes = containers.Map({'Dirichlet','Neumann'},{dirichletNodes,[]});



        