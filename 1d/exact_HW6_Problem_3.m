function U = exact_HW6_Problem_3(X,t)

% INPUTS: X = Points at which to evaluate the solution
%         t = Time at which to evaluate the solution
% OUTPUT: U = Exact solution at points X and time t

X = X-t;
delta = 2.5;
U = (abs(X)<delta).*exp(-delta^2./(delta^2-abs(X).^2))/exp(-1) + 0;

end