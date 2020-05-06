## finite-element-code

This code computes a finite-element solution to boundary value problems of the form:
<br> 

$$-\nabla\cdot(k(x,y)\;\nabla u(x,y)) + b(x,y)\;u(x,y) = f(x,y)$$

on the rectangular domain $\Omega$.

With $N$ nodes and basis functions $\phi(x,y)_{i=1,2,...,N}$ , our FEM solution takes the form:
$$\sum_{i=1}^{N} \alpha_i\;\phi_i(x,y)$$
where $\phi_i(x,y)$ are piece-wise linear 'pyramid-shaped' functions about node $i$. 
<br><br> 
Also, let $u = \alpha_1,\alpha_2,...,\alpha_i$. 
Then, $u$ is computed by $u=K^{-1}F$ where $K$ is the global stiffness matrix and $F$ is the global load vector.

By default, the code uses a structured triangular mesh, but this can be easily maniputed in ```user_input.m```.

<br><br>



Currently only supports Dirichlet boundary conditions.*

_______________________________________________________________________________________________________________________________
    
<br>

Begin by running ```main_2d.m```, which consists of the following steps:
```java
user_input; //read problem input
psi = polyLagrange2D(p); //determine Lagrange shape functions of degree p (always using linear elements, p = 1)
[K,F]=element2D(psi,KofXY,BofXY,FofXY,MESH); //compute load/stiffness matrices
[K,F]=enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes); //enforce boundary conditions
u=K\F; 
trimesh(MESH.ConnectivityList,MESH.Points(:,1),MESH.Points(:,2),u); //plot solution
```
_______________________________________________________________________________________________________________________________
For example, 
$$-

<div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/figures/2.1_dirichlet_exact.jpg" align="left" width=400 height = auto> 
    </div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/figures/2.1_dirichlet_mesh3.jpg" align="right" width=400 height = auto> 
    </div>
</div>
