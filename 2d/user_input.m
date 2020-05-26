p = 1;



k_func = (@(x,y) (x-2)^2*(y)+(y-2)^2);
b_func = (@(x,y) 0);
f_func = (@(x,y) (x-2)*(y-2));

%change domain shape
%rectangle_mesh;
%circle_mesh;
%custom_mesh1;
custom_mesh2;

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

































