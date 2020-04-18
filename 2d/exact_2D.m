function U = exact_2D(X,Y,probid)

%-----------------------------------------------------------------
%
%  Input:
%  ------
%       
%  X, Y   = array of points at which to evaluate the exact solution
%  probid = character string identifying problem (specified in 
%           input.2d) 
%
%  Output:
%  -------
%
%  U = exact solution evaluted at points X, Y    
%
%-----------------------------------------------------------------

if     (probid == 'Problem 2.1 DBC ')
    U = X.*Y.*(1-X).*(1-Y);        
elseif (probid == 'Problem 2.1 MBC ') 
    U = (X.^2-X).*(Y.^2-1);
elseif (probid == 'Problem 2.2     ')    
    U = (cosh(10*X) + cosh(10*Y))/(2*cosh(10));
elseif (probid == 'Final Exam Prob ')   
    U = X.*Y.*(1-X).*(1-Y);
else
    U = -9999*ones(size(X));
end