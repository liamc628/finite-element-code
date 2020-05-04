assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\tests\test');
read_1D_mesh;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\tests\test');
read_1D_input;







psi=polyLagrange(p);
[ke,fe,ae]=element1D(psi);
[K,F,M]=assemble1D(KofX,BofX,FofX,ke,fe,ae,MESH);
[K,F]=enforceBCs(K,F,KofX,boundaryValues,boundaryNodes);
u0=K\F;
L=-inv(M)*K;

dt=0.1;
T=0;
steps=T/dt;
%u0=exact_HW6_Problem_3(MESH.Points,0);
utemp=u0;
un=u0;
for n=1:steps
    un=utemp+dt*L*utemp;
    utemp=un;
end

fem1Dplot(MESH,un,psi);

flux_1 = -1.7*1*(100-u0(2))/(1-MESH.Points(2))
flux_10 = -1.7*10*(0-u0(nNodes-1))/(MESH.Points(nNodes)-MESH.Points(nNodes-1))




