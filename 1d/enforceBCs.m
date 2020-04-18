function [K,F] = enforceBCs(K,F,KofX,boundaryValues,boundaryNodes)
    p=evalin('base','p'); %degree
    %count number of Dirichlet/Neumann conditions to determine whether
    %pure/mixed BC case
    numDirichlet=size(boundaryValues('Dirichlet'));
    numNeumann=size(boundaryValues('Neumann'));
    nNodes=length(K);
    if(numDirichlet(1)==2) %both Dirchlet BCs
        boundary=boundaryValues('Dirichlet');
        K(1,:)=zeros(1,nNodes);
        K(nNodes,:)=zeros(1,nNodes);
        K(1,1)=1; K(nNodes,nNodes)=1;
        F(1)=boundary(1);
        F(nNodes)=boundary(2);
        
        %rearrange middle rows and manipulate rows
        %(loop is for higher degree elements p>1)
        for i=2:2+p
            F(i)=F(i)-K(i,1)*boundary(1);
            K(i,1)=0;
        end
        
        for i=(nNodes-1):-1:(nNodes-1-p)
            F(i)=F(i)-K(i,nNodes)*boundary(2);
            K(i,nNodes)=0;
        end
        
    elseif(numNeumann(1)==1 && numDirichlet(1)==1) %Mixed BCs
        
        %Dirichlet boundary condition
        dirichletNode=boundaryNodes('Dirichlet');
        F(dirichletNode)=boundaryValues('Dirichlet');
        
        %depending on which side is the Dirichlet BC,
        %rearrange rows accordingly
        if(dirichletNode==1)
            for i=2:2+p
                F(i)=F(i)-K(i,1)*boundaryValues('Dirichlet');
                K(i,1)=0;
            end
            F(length(F))=F(length(F))+KofX(length(KofX))*boundaryValues('Neumann');
        elseif(dirichletNode==nNodes)
            for i=(nNodes-1):-1:(nNodes-1-p)
                F(i)=F(i)-K(i,nNodes)*boundaryValues('Dirichlet');
                K(i,nNodes)=0;
            end
            F(1)=F(1)-KofX(1)*boundaryValues('Neumann');
        end     
        K(dirichletNode,:)=zeros(1,nNodes);
        K(dirichletNode,dirichletNode)=1;
        
    end
end

