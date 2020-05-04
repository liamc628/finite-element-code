p = 1;

k_str = input('input k(x,y): ', 's');
k_str = ['@(x,y) ',k_str];
k_func = str2func(k_str);

b_str = input('input b(x,y): ', 's');
b_str = ['@(x,y) ',b_str];
b_func = str2func(b_str);

f_str = input('input f(x,y): ', 's');
f_str = ['@(x,y) ',f_str];
f_func = str2func(f_str);

D_x = input('input x-domain (vector):');
D_y = input('input y-domain (vector):');

%----------------------------------------------|
%            boundary 2                        |
%              ______                          |
%             |      |                         |
%  boundary 1 |      | boundary 3              |
%             |______|                         |
%            boundary 4                        |
%----------------------------------------------|

%Dirichlet
%{
boundary_1_str = input(['u(',num2str(D_x(1)),',y) = '],'s');
boundary_1_str = ['@(y)',boundary_1_str];
boundary_2_str = input(['u(x,',num2str(D_y(2)),') = '],'s');
boundary_2_str = ['@(x)',boundary_2_str];
boundary_3_str = input(['u(',num2str(D_x(2)),',y) = '],'s');
boundary_3_str = ['@(y)',boundary_3_str];
boundary_4_str = input(['u(x,',num2str(D_y(1)),') = '],'s');
boundary_4_str = ['@(x)',boundary_4_str];

boundary_1_func = str2func(boundary_1_str);
boundary_2_func = str2func(boundary_2_str);
boundary_3_func = str2func(boundary_3_str);
boundary_4_func = str2func(boundary_4_str);
%}

boundary_1_func = (@(y) 0);
boundary_2_func = (@(x) 0);
boundary_3_func = (@(y) 0);
boundary_4_func = (@(x) 0);

%BC check corners


%Generate Mesh
%{
x_precision = 0.05;
y_precision = 0.05;
x=D_x(1):x_precision:D_x(2);
y=D_y(1):y_precision:D_y(2);
[x,y]=meshgrid(x,y);
%}
x = [0 0.5 0.25 0 0.5 0.25 0 0.5 1 0.75 1 0.75 1];
y = [0 0 0.25 0.5 0.5 0.75 1 1 0 0.25 0.5 0.75 1];
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
    if ismember(D_x(1),MESH.Points(dirichletNodes(i),:)) %boundary 1
        dirichletValues(i) = boundary_1_func(MESH.Points(dirichletNodes(i),2));
    elseif ismember(D_y(2),MESH.Points(dirichletNodes(i),:)) %boundary 2
        dirichletValues(i) = boundary_2_func(MESH.Points(dirichletNodes(i),1));
    elseif ismember(D_x(2),MESH.Points(dirichletNodes(i),:)) %boundary 3
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

































