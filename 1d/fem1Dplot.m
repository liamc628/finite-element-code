function fem1Dplot(MESH,u,psi)
    p = length(psi)-1;
    nElems = size(MESH.ConnectivityList, 1);
    nPoints = 20;
    shapeFunctionValues = zeros(p+1,nPoints);
    % Evaluate the shape functions at the set of plotting points
    for i = 1:p+1
        for j = 1:nPoints
            shapeFunctionValues(i,j) = polyval(psi(i).fun,-1+2/(nPoints-1)*(j-1));
        end
    end    
    ii = 0;
    for i = 1:nElems
        % Compute the FEM solution at the plotting points
        for k = 1:nPoints
            uh(k) = 0;
            for j = 1:p+1
                uh(k) = uh(k) + u(ii+j)*shapeFunctionValues(j,k);
            end
        end
        % Retrieve the node numbers for the element
        node1 = MESH.ConnectivityList(i,1);
        node2 = MESH.ConnectivityList(i,2);
        % Compute the points over the element in x coordinates
        Xplot = linspace(MESH.Points(node1),MESH.Points(node2),20);
        % Plot the FEM solution over the element
        plot(Xplot,uh); hold on;
        ii = ii+j-1;
    end
end



