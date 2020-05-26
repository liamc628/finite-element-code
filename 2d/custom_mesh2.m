



model = createpde;
R1 = [3,4,0,4,4,0,0,0,4,4]';
C1 = [1,2,0,1.2]'; C1 = [C1;zeros(length(R1) - length(C1),1)];
C2 = [1,4,2,1.2]'; C2 = [C2;zeros(length(R1) - length(C2),1)];
C3 = [1,2,4,1.2]'; C3 = [C3;zeros(length(R1) - length(C3),1)];
C4 = [1,0,2,1.2]'; C4 = [C4;zeros(length(R1) - length(C4),1)];
gd = [R1,C1,C2,C3,C4];
sf = 'R1-C1-C2-C3-C4';
ns = char('R1','C1','C2','C3','C4');
ns = ns';
geo = decsg(gd,sf,ns);
geometryFromEdges(model,geo);
mesh = generateMesh(model,'GeometricOrder','linear','Hmax',0.05);
MESH = triangulation(mesh.Elements',mesh.Nodes(1,:)',mesh.Nodes(2,:)');
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
triplot(MESH);

dirichletNodes = unique(freeBoundary(MESH));
dirichletValues = zeros(length(dirichletNodes),1);

boundaryValues = containers.Map({'Dirichlet','Neumann'},{dirichletValues,[]});
boundaryNodes = containers.Map({'Dirichlet','Neumann'},{dirichletNodes,[]});