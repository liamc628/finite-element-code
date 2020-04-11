assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\HW6_Test_Problem_1\Mesh1');
read_1D_mesh;
assignin('base','filePath', 'C:\Users\monke\OneDrive\Desktop\5168\project\1d\HW6_Test_Problem_1\Mesh1');
read_1D_input;







psi=polyLagrange(p);
[ke,fe]=element1D(psi);
[K,F,M]=assemble1D(KofX,BofX,FofX,ke,fe,MESH);
[K,F]=enforceBCs(K,F,boundaryValues,boundaryNodes);
u0=K\F;
L=-inv(M)*K;

dt=0.1;
T=5;
steps=T/dt;

utemp=u0;
for n=1:steps
    un=utemp+dt*L*utemp;
    utemp=un;
end


%disp(u);
fem1Dplot(MESH,un,psi);



