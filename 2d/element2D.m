function [ke,fe] = element2D(psi)
%ELEMENT2D Summary of this function goes here
%   Detailed explanation goes here
    ke = struct('k',[],'b',[]);
    fe = zeros(length(psi),1);   
    degree = length(psi)-1;
end

