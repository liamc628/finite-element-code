clear all;

assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.1\Mixed\Structured Mesh');

read_2D_mesh;

assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\2d\Problem_2.1\Mixed\Structured Mesh');

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

u_exact=x.*y.*(1-x).*(1-y);





%2.1 Mixed exact solution

%u_exact=(x.^2-x).*(y.^2-1);



%2.2 exact solution (Inhomogenous Dirichlet)

%u_exact=(cosh(10*x)+cosh(10*y))/(2*cosh(10));

surf(x,y,u_exact);
%--------------------------------------------------------------------------


%error
u_function=(@(x,y) (x*y*(1-x)*(1-y)));
%u_function=(@(x,y) (cosh(10*x)+cosh(10*y))/(2*cosh(10)));

L_2=0; L_inf=0;
q=quadtriangle(3);

xi=[0 0 1]; eta=[0 1 0]; polyvals = zeros(3,1);

for i=1:3
    polyvals(i)=bipolyval(psi(i).fun,[xi(i),eta(i)]);
end

for i=1:nElems
    currElement = MESH.ConnectivityList(i,:);
    one = currElement(1); two = currElement(2); three = currElement(3); %local node numbers
    
    x=[MESH.Points(one,1) MESH.Points(two,1) MESH.Points(three,1)];
    y=[MESH.Points(one,2) MESH.Points(two,2) MESH.Points(three,2)];
    u_coeffs=[u(one) u(two) u(three)];
    
    element_area = polyarea([x(1) x(2) x(3)], [y(1) y(2) y(3)]);
    
    for j=1:3
        u_h=dot(u_coeffs,polyvals);
        x_j=dot(x,polyvals); y_j=dot(y,polyvals);
        u_xy=u_function(x_j,y_j);
        
        L_2=L_2+q.Weights(j)*2*element_area*(u_xy-u_h)^2;
        L_inf=max(L_inf,abs(u_xy-u_h));
        %disp(L_2);
       
    end       
end

L_2=sqrt(L_2);

disp(['L_2 error norm:',num2str(L_2)]);
disp(['L_inf error norm:',num2str(L_inf)]);





























