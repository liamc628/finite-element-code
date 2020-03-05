# Finite-element code

This code produces a finite-element solution to boundary value problems in the form: 


<img src="https://render.githubusercontent.com/render/math?math=-\frac{d}{dx} \big(k(x)\frac{du(x)}{dx}\big) %2B b(x)u(x) = f(x)" width=70% height=70%>


For efficiency, k(x), b(x), and f(x) are discretized across each element domain to simplify Gauss quadrature calculations.

## 1D MATLAB instructions for n-element BVP 
```MATLAB
read_1D_mesh;
read_1D_input;
psi = polyLagrange(p); %shape function & derivative (psi) of degree p
[ke,fe] = element1D(psi); %compute master element
[K,F] = assemble1D(KofX,BofX,FofX,ke,fe,MESH); %assemble (n+1)x(n+1) system Ku=F
[K,F]=enforceBCs(K,F,boundaryValues,boundaryNodes); %enforce Neumann/Dirichlet BCs
u = K\F;
```
### 1d\test\dirichlet results:
```MATLAB
K =

    1.0000         0         0         0         0         0
         0   30.0000  -25.5000         0         0         0
         0  -25.5000   32.5000   -7.0000         0         0
         0         0   -7.0000   22.5000  -15.5000         0
         0         0         0  -15.5000   20.0000         0
         0         0         0         0         0    1.0000


F =

         0
    0.1500
    0.1250
    0.1500
    0.2500
         0
u =

         0
    0.0716
    0.0783
    0.0851
    0.0784
         0
```
### 1d\tests\dirichlet plot (FEM solution vs. exact)
![](/1d/tests/dirichlet/plot.png)

