function F = bipolyval(P,X)

%% BIPOLYVAL Bipolynomial evaluation
%    F = BIPOLYVAL(P,X), returns the value(s) of the bivariate polynomial P 
%    evaluated at X, where X is an N by 2 array, i.e., X = [ x1 y1; x2 y2; 
%    ... xN yN]. Analogous to Matlab polynomial form, a bipolynomial of the 
%    form
%
%    P(x,y) = p_(1,1)*x^n*y^m + p_(1,2)*x^(n-1)*y^m + ... 
%              + p_(1,n)*x*y^m + p_(1,n+1)*y^m + p_(2,1)*x^n*y^(m-1) + ...
%                +  p_(2,2)*x^(n-1)*y^(m-1) + ... + p_(n+1,n+1)*x^0*y^0
%
%    would be arranged as
%
%              x^n      x^(n-1)   ...       x^1         x^0
%           ---------------------------------------------------
%    P =  [ p_(  1,1), p_(  1,2), ... , p_(  1,n), p_(  1,n+1) ]  y^m
%         [ p_(  2,1), p_(  2,2), ... , p_(  2,n), p_(  2,n+1) ]  y^(m-1)
%         [     .         .      .           .          .      ]   .  
%         [     .         .        .         .          .      ]   .
%         [     .         .          .       .          .      ]   . 
%         [ p_(  m,1), p_(m  ,2), ... , p_(  m,n), p_(  m,n+1) ]  y^1
%         [ p_(m+1,1), p_(m+1,2), ... , p_(m+1,n), p_(m+1,n+1) ]  y^0.
%    
%    See also bipolyder, bipoly2sym 
%    Detailed help, with examples, available online at:   
%    http://u.osu.edu/kubatko.3/codes_and_software/polytools/bipolyval/
%

%% Validata input

vP = @(x)validateattributes(x,{'numeric'},{'2d'});
vX = @(x)validateattributes(x,{'numeric'},{'ncols',2});
ip = inputParser;
ip.addRequired('P',vP); ip.addRequired('X',vX);
ip.parse(P,X);
ip.Results;

%% Compute the value(s) of the bipolynomial at points X

n = size(P,1)-1; N = size(X,1);
F = zeros(N,1); pval = zeros(n+1,1);
for i = 1:N
    for j = 0:n
        pval(j+1) = polyval(P(j+1,:)*X(i,2)^(n-j),X(i,1));
    end
    F(i) = sum(pval);
end

end

 