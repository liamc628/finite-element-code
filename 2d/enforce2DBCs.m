function [K,F] = enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes)
    numDirichlet = length(boundaryNodes('Dirichlet'));
    nNodes = length(K);
    dirichletValues = boundaryValues('Dirichlet');
    dirichletNodes = boundaryNodes('Dirichlet');
    
    for i = 1:numDirichlet
        currDirichlet = dirichletNodes(i);
        K(currDirichlet,:)=zeros(1,nNodes);
        K(currDirichlet,currDirichlet)=1;
        F(currDirichlet)=dirichletValues(i);
        
        for j =1:nNodes %columns
            F(j)=F(j)-K(j,currDirichlet)*dirichletValues(i);
        end
        
    end

end