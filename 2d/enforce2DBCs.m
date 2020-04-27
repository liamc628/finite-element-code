function [K,F] = enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes)
numDirichlet = length(boundaryNodes('Dirichlet'));
nNodes = length(K);
dirichletValues = boundaryValues('Dirichlet');
dirichletNodes = boundaryNodes('Dirichlet');

for currDirichlet = 1:numDirichlet  
    for j =1:nNodes %columns
        F(j)=F(j)-K(j,dirichletNodes(currDirichlet))*dirichletValues(currDirichlet);
        K(j,dirichletNodes(currDirichlet))=0;
    end
end

for currDirichlet = 1:numDirichlet
    K(dirichletNodes(currDirichlet),:)=zeros(1,nNodes);
    
    K(dirichletNodes(currDirichlet),dirichletNodes(currDirichlet))=1;
    F(dirichletNodes(currDirichlet))=dirichletValues(currDirichlet);
    %disp(K(currDirichlet,:));
    
end


end