
k_str = input('input k(x,y): ', 's');
k_str = ['@(x,y)',k_str];
k_func = str2func(k_str);

b_str = input('input b(x,y): ', 's');
b_str = ['@(x,y)',b_str];
b_func = str2func(b_str);

f_str = input('input f(x,y): ', 's');
f_str = ['@(x,y)',f_str];
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

%Currently only Dirichlet/Homogenous Neumann BCs
boundary_1_str = input(['u(',num2str(D_x(1)),',y) = '],'s');
boundary_1_str = ['@(y)',boundary_1_str];
boundary_2_str = input(['u(x,',num2str(D_y(2)),') = '],'s');
boundary_2_str = ['@(x)',boundary_2_str];
boundary_3_str = input(['u(',num2str(D_x(2)),',y) = '],'s');
boundary_3_str = ['@(y)',boundary_3_str];
boundary_4_str = input(['u(x,',num2str(D_y(1)),') = '],'s');
boundary_4_str = ['@(x)',boundary_4_str];

%Generate Mesh




























