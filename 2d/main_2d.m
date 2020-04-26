clear all;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.2\Mesh_3');
read_2D_mesh;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.2\Mesh_3');
read_2D_input;

psi = polyLagrange2D(p);
[K,F]=element2D(psi,KofXY,BofXY,FofXY,MESH);
[K,F]=enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes);
u=K\F;
trimesh(MESH.ConnectivityList,MESH.Points(:,1),MESH.Points(:,2),u); %FEM solution

figure(2);
x=0:0.01:1;
y=0:0.01:1;
[x,y]=meshgrid(x,y);
%2.1 Dirichlet exact solution
%u_exact=x.*y.*(1-x).*(1-y);


%2.1 Mixed exact solution
%u_exact=(x.^2-x).*(y.^2-1);

%2.2 exact solution (Inhomogenous Dirichlet)
u_exact=(cosh(10*x)+cosh(10*y))/(2*cosh(10));
surf(x,y,u_exact);




