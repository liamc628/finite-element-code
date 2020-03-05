%function that returns Lagrange polynomials of degree k and their
%derivatives
function psi = polyLagrange(k)
    %define a 'psi' structure of size k+1, each with a function and
    %derivative element
    psi(k+1) = struct('fun',[],'der',[]);
    
    %define k+1 nodes spaced evenly from [-1,1] inclusively
    nodes = linspace(-1,1,k+1);
    
    %yvals needed in order to fit polynomial later
    yvals = zeros(1,k+1);
    
    %loop to create k+1 Lagrange elements
    for j = 1:k+1
        %psi-j should equal 1 at the j-th node and 0 at all other nodes
        yvals(j) = 1;
        %polyfit fits a k-th degree polynomial to k+1 (x,y) values
        p=polyfit(nodes,yvals,k);
        %set function/derivative elements accordingly
        psi(j).fun = p;
        psi(j).der = polyder(p);
        %reset all yvals to 0 for next iteration
        yvals(j)=0;
    end      
end

