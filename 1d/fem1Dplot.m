function fem1Dplot(MESH,u,psi)
    p=evalin('base','p');
    nElems=evalin('base','nElems');
    nPoints=20;
    shapeFunctionValues = zeros(p+1,nPoints);
    for i = 1:p+1
        for j = 1:nPoints
            shapeFunctionValues(i,j) = polyval(psi(i).fun,-1+(j-1)*(2/nPoints));
        end
    end
    
    for i = 1:nElems
        for k = 1:nPoints
            uh(k) = 0;
            for j = 1:p+1
                uh(k) = uh(k) + u(j)*shapeFunctionValues(j,k);
            end
        end
        Xplot = linspace(MESH.Points(1),MESH.Points(nElems+1),20);
        plot(Xplot,uh);
    end
    disp(shapeFunctionValues);
disp(Xplot);
disp(uh);    
end



