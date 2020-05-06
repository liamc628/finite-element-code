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



Currently only supports Dirichlet boundary conditions (or homogenous Neumann BCs for the mixed case).*

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
### Example 1:
<br>
Solving
$$-\nabla^2u(x,y)+u(x,y) = \pi^2e^{-x}sin(\pi y) \text{ on the unit square } \Omega:[0,1]\times[0,1]$$
<br>
with Dirichlet boundary conditions
<br>
$$u(0,y) = sin(\pi y),\; u(x,1) = 0,\; u(1,y) = \frac{sin(\pi y)}{e},\; u(x,0) = 0$$
<br>
we obtain an exact solution of $u(x,y) = e^{-x}sin(\pi y)$ (left), compared to our FEM solution (right).

<div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/test_figures/exp(-x)sin(piy)_exact.jpg" align="left" width=400 height = auto> 
    </div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/test_figures/exp(-x)sin(piy)_fem.jpg" align="right" width=400 height = auto> 
    </div>
</div>

<br>
____________________________________________________________________________________________________________________________

### Example 2:
<br>
Solving
$$-\nabla\cdot((1+xy^2)\nabla u(x,y)) = 2-3y^2-6x^3y^2+y^4+x^2(6y^2-2)+x(2+4y^2-4y^4)$$
<br>
with mixed boundary conditions
<br>
$$u(0,y) = u(x,1) = u(1,y) = 0,\; \frac{\partial u(x,0)}{\partial y} = 0 $$
<br>
we find our exact solution to be $u(x,y) = (x^2+x)(y^2-1)$ (left) and also an FEM solution, this time using an unstructured mesh (right).
<div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/problem_figures/2.1_mixed_exact.jpg
" align="left" width=400 height = auto> 
    </div>
    <div>
<img src="https://raw.githubusercontent.com/liamc628/finite-element-code/master/2d/problem_figures/2.1_mixed_unstructured.jpg" align="right" width=400 height = auto> 
    </div>
</div>



```python

```
