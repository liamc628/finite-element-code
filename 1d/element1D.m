function [ke,fe,ae] = element1D(psi)
    %pre-allocate ke,fe,degree
    ke = struct('k',[],'b',[]);
    fe = zeros(length(psi),1);  
    ae = zeros(length(psi));
    degree = length(psi)-1;
    
    
    %integrate exactly with Gaussian quadrature
    q = quadGaussLegendre(ceil((2*degree+1)/2));
    
    %arrange ke.k and ke.b matrices...
    %... efficiently by taking advantage of symmetry 
    for i = 1:length(psi)
        for j = 1:i
            ke.k(i,j) = dot(q.Weights,polyval(conv(psi(i).der,psi(j).der),q.Points));
            ke.k(j,i) = ke.k(i,j);
            ke.b(i,j) = dot(q.Weights,polyval(conv(psi(i).fun,psi(j).fun),q.Points));
            ke.b(j,i) = ke.b(i,j);
            
        end
        %arrange fe vector
        fe(i) =  dot(q.Weights,polyval(psi(i).fun,q.Points));
    end
    
    for i=1:length(psi)
        for j=1:length(psi)
            ae(i,j) = dot(q.Weights,polyval(conv(psi(i).fun,psi(j).der),q.Points));
        end
    end
end

