function psi = polyLagrange2D(k)

p=k;

T = polyshape([0 1 0],[0 0 1]);

[xi,eta] = meshgrid(0:1/p:1);

xi = reshape(xi',[],1);

eta = reshape(eta',[],1);

I = find(xi+eta<=1);

xi = xi(I);

eta = eta(I);

N = length(xi);

k = 1;

for i = 0:p

    for j = 0:i

        % Compute column k of the Vandermode matrix

        V(:,k) = xi.^(i-j).*eta.^j;

        k = k + 1;

    end

end



I = eye(N);

a = zeros(N);

for i = 1:N

    a(:,i) = V\I(:,i);

end



for l = 1:N

    psi(l).fun = zeros(p+1);

    k = 1;

    for i = 0:p

        for j = 0:i

            psi(l).fun(end-j,end-(i-j)) = a(k,l);

            k = k+1;

            psi(l).xider=bipolyder(psi(l).fun,1);

            psi(l).etader=bipolyder(psi(l).fun,2 );

        end

    end

    % Plot the resulting bipolynomials to verify they satisfy the nodal

    % conditions

    %{

    figure;

    bipolyplot(psi(l).fun,T); hold on;

    plot3(xi,eta,zeros(size(xi)),'ko','MarkerFaceColor','k')

    %}

end

end