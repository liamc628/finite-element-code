function vals = sympolyval(f, points)
    
    dim=size(points);
    numpoints=dim(1);
    vals = zeros(numpoints,1);
    for i = 1:numpoints
        vals(i)=f(points(i,1),points(i,2));
    end
end