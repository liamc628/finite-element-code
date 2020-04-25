assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.1\Dirichlet\Mesh 1');
read_2D_mesh;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.1\Dirichlet\Mesh 1');
read_2D_input;

psi = polyLagrange2D(p);
[K,F]=element2D(psi,KofXY,BofXY,FofXY,MESH);
[K,F]=enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes);
u=K\F;
trimesh(MESH.ConnectivityList,MESH.Points(:,1),MESH.Points(:,2),u); %FEM solution


