%outer boundary
boundary_1_func = (@(x) 0);

%inner boundary
boundary_2_func = (@(t) sin(3*t));



model = createpde;
max_elem_size = 0.05;

R1 = [3,4,0,2,2,0,0,0,2,2]';
C1 = [1,1,1,0.25]';
C1 = [C1;zeros(length(R1) - length(C1),1)];
gd = [R1,C1];
sf = 'R1-C1';
ns = char('R1','C1');
ns = ns';
geo = decsg(gd,sf,ns);
geometryFromEdges(model,geo);
mesh = generateMesh(model,'GeometricOrder','linear','Hmax',max_elem_size);
MESH = triangulation(mesh.Elements',mesh.Nodes(1,:)',mesh.Nodes(2,:)');
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
triplot(MESH);

dirichletNodes = unique(freeBoundary(MESH));
rectNodes = [];

for i = 1:length(dirichletNodes)
    if(MESH.Points(dirichletNodes(i),1) == 0 || MESH.Points(dirichletNodes(i),1) == 2 ... 
        || MESH.Points(dirichletNodes(i),2) == 0 || MESH.Points(dirichletNodes(i),2) == 2)
        rectNodes = [rectNodes dirichletNodes(i)];
    end
end
circleNodes = setdiff(dirichletNodes, rectNodes);

dirichletValues = zeros(length(dirichletNodes),1);
dirichletValues(circleNodes) = boundary_2_func(cart2pol(MESH.Points(circleNodes,1)-1,MESH.Points(circleNodes,2)-1));
dirichletValues(rectNodes) = boundary_1_func(0);

boundaryValues = containers.Map({'Dirichlet','Neumann'},{dirichletValues,[]});
boundaryNodes = containers.Map({'Dirichlet','Neumann'},{dirichletNodes,[]});


