p = 1;



k_func = (@(x,y) 1);
b_func = (@(x,y) 1);
f_func = (@(x,y) 2-3*y^2-6*x^3*y^2+y^4+x^2*(6*y^2-2)+x*(2+4*y^2-4*y^4));

D_x = [0,1] %x-domain
D_y = [0,1] %y-domain

%----------------------------------------------|
%            boundary 2                        |
%              ______                          |
%             |      |                         |
%  boundary 1 |      | boundary 3              |
%             |______|                         |
%            boundary 4                        |
%----------------------------------------------|

%Dirichlet

boundary_1_func = (@(y) 0);
boundary_2_func = (@(x) 0);
boundary_3_func = (@(y) 0);
boundary_4_func = (@(x) 0);

%BC check corners
if(boundary_1_func(D_y(1)) ~= boundary_4_func(D_x(1)))
    disp('Warning: lower-left corner BC');
end

if(boundary_1_func(D_y(2)) ~= boundary_2_func(D_x(1)))
    disp('Warning: top-left corner BC');
end

if(boundary_2_func(D_x(2)) ~= boundary_3_func(D_y(2)))
    disp('Warning: top-right corner BC');
end

if(boundary_4_func(D_x(2)) ~= boundary_3_func(D_y(1)))
    disp('Warning: lower-left corner BC');
end

%Generate Mesh

x_precision = 0.05;
y_precision = 0.05;
x=D_x(1):x_precision:D_x(2);
y=D_y(1):y_precision:D_y(2);
[x,y]=meshgrid(x,y);

T=delaunay(x,y);
MESH = triangulation(T,x(:),y(:));
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
triplot(MESH);

%set boundary nodes/values
[dirichletNodes,col] = find(MESH.Points==D_x(1)|MESH.Points==D_x(2)|MESH.Points==D_y(1)|MESH.Points==D_y(2));
dirichletNodes = unique(dirichletNodes);
dirichletValues = zeros(length(dirichletNodes),1);

for i=1:length(dirichletNodes)
    if D_x(1) == MESH.Points(dirichletNodes(i),1) %boundary 1
        dirichletValues(i) = boundary_1_func(MESH.Points(dirichletNodes(i),2));
    elseif D_y(2) == MESH.Points(dirichletNodes(i),2) %boundary 2
        dirichletValues(i) = boundary_2_func(MESH.Points(dirichletNodes(i),1));
    elseif D_x(2) == MESH.Points(dirichletNodes(i),1) %boundary 3
        dirichletValues(i) = boundary_3_func(MESH.Points(dirichletNodes(i),2));
    else %boundary 4
        dirichletValues(i) = boundary_4_func(MESH.Points(dirichletNodes(i),1));
    end
end

boundaryValues = containers.Map({'Dirichlet','Neumann'},{dirichletValues,[]});
boundaryNodes = containers.Map({'Dirichlet','Neumann'},{dirichletNodes,[]});

%set k(x,y), b(x,y),f(x,y) values
KofXY = zeros(nElems,1); BofXY = zeros(nElems,1); FofXY = zeros(nElems,1); 
for i=1:nElems
    currElement = MESH.ConnectivityList(i,:);
    points = MESH.Points(currElement,:);
    poly = polyshape(points(:,1),points(:,2));
    [cent_x,cent_y] = centroid(poly);

    KofXY(i) = k_func(cent_x,cent_y);
    BofXY(i) = b_func(cent_x,cent_y);
    FofXY(i) = f_func(cent_x,cent_y);
end

































