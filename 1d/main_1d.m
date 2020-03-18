read_1D_mesh;
read_1D_input;
psi=polyLagrange(p);
[ke,fe]=element1D(psi);
[K,F]=assemble1D(KofX,BofX,FofX,ke,fe,MESH);
[K,F]=enforceBCs(K,F,boundaryValues,boundaryNodes);
u=K\F;
disp(u);