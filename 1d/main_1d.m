assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\Problem_1.2\Mesh_4');
read_1D_mesh;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\Problem_1.2\Mesh_4');
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

utemp=u0;
for n=1:steps
    un=utemp+dt*L*utemp;
    utemp=un;
end


%disp(u);
fem1Dplot(MESH,u0,psi);



