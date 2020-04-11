function varargout = bipolyplot(varargin)

%% POLYPLOT Plots a MATLAB® polynomial
%     BIPOLYPLOT(B) plots the bipolynomial represented by the matrix B 
%     over the domain [-1,1] x [-1,1].    
%
%     BIPOLYPLOT(B,P) plots the bipolynomial B over the domain specified by 
%     a polyshape object P (see help polyshape for details).
%
%     h = BIPOLYPLOT( ___ ) returns a column vector of patch properties. 
%     Use h to modify properties of a specific bipolynomial plot after it  
%     is created. 
%
%     See also polyplot, quadplot
%
%     Detailed help, with examples, available online at:   
%     http://u.osu.edu/kubatko.3/codes_and_software/polytools/bipolyplot/
%

%% Validate input

vB = @(x)validateattributes(x,{'numeric'},{'real','2d'});
n = 1;
D = polyshape([-1 1 1 -1],[-1 -1 1 1]);
if nargin >= 2
    if ~ischar(varargin{2})
        n = 2;
        if ~isa(varargin{2},'polyshape')
            error('Domain D of the plot must be specified as a polyshape');
        else
            D = varargin{2};
        end
    end
end
ip = inputParser;
ip.addRequired('B',vB); 
ip.parse(varargin{1});
ip.Results; B = ip.Results.B; 

%% Plot bipolynomial

TR = trirefine(triangulation(D),5);
Bval = bipolyval(B,[TR.Points(:,1),TR.Points(:,2)]);
hold on; box on; grid on;
h = trisurf(TR.ConnectivityList,TR.Points(:,1),TR.Points(:,2),Bval,...
    'EdgeColor','none','FaceColor','interp',varargin{n+1:end});
plot(D); view(3);
hold off
if nargout == 1
    varargout{1} = h;
end

end

function varargout = trirefine(TR,varargin)

%% TRIREFINE Uniform triangulation refinement
%    rTR = trirefine(TR) returns a triangulation that is a uniform
%    refinement of the input triangulation TR. Each element of TR is
%    subdivided into 4 triangles by joining the midpoints of the edges,
%    i.e.,
%
%            /\                        /\
%           /  \                      /__\
%          /    \       ==>          /\  /\
%         /______\                  /__\/__\
%     Original triangle      Triangle after refinement
%
%    rTRk = trirefine(TR,k) same as above but successively refines the 
%    input triangulation TR k times.
%
%    [rTR1, rTR2, ..., rTRk] = trirefine(TR,k) same as above but returns 
%    the sequence of k refined triangulations. Note: The output can also be 
%    saved to a cell array using the notation [rTR{1:k}] = trirefine(TR,k).
%
%    See also triangulation, triplot, trimesh, trisurf 

%% Validate input
if ~isa(TR,'triangulation')
    error('Input must be of the triangulation class')
else    
    vk = @(x)validateattributes(x,{'numeric'},{'scalar','nonnegative','integer'});
    ip = inputParser;
    ip.addRequired('TR'); ip.addOptional('k',1,vk);
    ip.parse(TR,varargin{:});
    ip.Results; k = ip.Results.k;
end

%% Uniformly refine mesh(es)

% Initialize the output
varargout = cell(nargout,1);
% Loop over the sequence of refinements
for r = 1:k
    % Retrieve the number of elements and vertices of the triangulation
    NElems = size(TR.ConnectivityList,1);
    NVerts = size(TR.Points,1);
    % Store the (directed "half") edges of the triangulation
    HalfEdges{1} = [TR.ConnectivityList(:,1),TR.ConnectivityList(:,2)];
    HalfEdges{2} = [TR.ConnectivityList(:,2),TR.ConnectivityList(:,3)];
    HalfEdges{3} = [TR.ConnectivityList(:,3),TR.ConnectivityList(:,1)]; 
    % Store the edges of the triangulation
    Edges = TR.edges;
    % Construct the element-to-edge table
    Elem2Edge = zeros(NElems,3);    
    for i = 1:3
        [~,iEdges,iElems]     = intersect([Edges(:,1),Edges(:,2)],HalfEdges{i},'rows');
        Elem2Edge(iElems,i)   = iEdges;
        [~,iEdges,iElems]     = intersect([Edges(:,2),Edges(:,1)],HalfEdges{i},'rows');
        Elem2Edge(iElems,i)   = iEdges;
    end
    % Compute and store coordinate of new vertices
    NewPoints = (TR.Points(Edges(:,1),:) + TR.Points(Edges(:,2),:))/2;
    % Store new connectivity list for refined elements
    NewConnectivityList1 = [ TR.ConnectivityList(:,1), NVerts+Elem2Edge(:,1), NVerts+Elem2Edge(:,3) ];
    NewConnectivityList2 = [ NVerts+Elem2Edge(:,1), TR.ConnectivityList(:,2), NVerts+Elem2Edge(:,2) ];
    NewConnectivityList3 = [ NVerts+Elem2Edge(:,3), NVerts+Elem2Edge(:,2), TR.ConnectivityList(:,3) ];
    NewConnectivityList4 = [ NVerts+Elem2Edge(:,1:3) ];
    % Contruct the refined triangulation
    TR = triangulation([NewConnectivityList1; NewConnectivityList2;...
        NewConnectivityList3; NewConnectivityList4 ],[TR.Points; NewPoints]);
    varargout{r} = TR;
end
if nargout == 1
    varargout{1} = TR;
end

end

