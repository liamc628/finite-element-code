function [K,F] = enforce2DBCs(K,F,KofXY,boundaryValues,boundaryNodes)
numDirichlet = length(boundaryNodes('Dirichlet'));
nNodes = length(K);
dirichletValues = boundaryValues('Dirichlet');
dirichletNodes = boundaryNodes('Dirichlet');

for currDirichlet = 1:numDirichlet  
    for j =1:nNodes %columns
        F(j)=F(j)-K(j,currDirichlet)*dirichletValues(currDirichlet);
        K(j,currDirichlet)=0;
    end
end

for currDirichlet = 1:numDirichlet
    K(currDirichlet,:)=zeros(1,nNodes);
    
    K(currDirichlet,currDirichlet)=1;
    F(currDirichlet)=dirichletValues(currDirichlet);
    %disp(K(currDirichlet,:));
    
end

end