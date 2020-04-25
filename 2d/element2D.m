function [K,F] = element2D(psi,KofXY,BofXY,FofXY,MESH)

%ke = struct('k',[],'b',[]);
fe = zeros(length(psi),1);
degree = length(psi)-1;

q = quadtriangle(3);
nElems = length(MESH.ConnectivityList);
nNodes = length(MESH.Points);
ke = zeros(length(psi));
K=zeros(nNodes);
F=zeros(nNodes,1);

for n = 1:nElems
    currElement = MESH.ConnectivityList(n,:);
    one = currElement(1); two = currElement(2); three = currElement(3); %local node numbers
    one_xy = MESH.Points(one,:); two_xy = MESH.Points(two,:); three_xy = MESH.Points(three,:); %global coords of local nodes
    element_area = polyarea([one_xy(1) two_xy(1) three_xy(1)], [one_xy(2) two_xy(2) three_xy(2)]);
    y_31 = three_xy(2)-one_xy(2); y_21 = three_xy(2)-two_xy(2);
    x_31 = three_xy(1)-one_xy(1); x_21 = three_xy(1)-two_xy(1);
    %disp(element_area);
    
    for i = 1:length(psi)
        for j = 1:i
            y_i=y_31*psi(i).xider-y_21*psi(i).etader;
            y_j=y_31*psi(j).xider-y_21*psi(j).etader;
            
            x_i=x_31*psi(i).xider-x_21*psi(i).etader;
            x_j=x_31*psi(j).xider-x_21*psi(j).etader;
            
            
            ke(i,j)=(1/(4*element_area))*KofXY(n)*((y_31*psi(i).xider(2,2)-y_21*psi(i).etader(2,2))*(y_31*psi(j).xider(2,2)-y_21*psi(j).etader(2,2))...
                +(x_31*psi(i).xider(2,2)-x_21*psi(i).etader(2,2))*(x_31*psi(j).xider(2,2)-x_21*psi(j).etader(2,2)))...
                +element_area*BofXY(n)*dot(q.Weights,bipolyval(psi(i).fun,q.Points).*bipolyval(psi(j).fun,q.Points));
            ke(j,i) = ke(i,j);
            
            K(currElement(i),currElement(j)) = K(currElement(i),currElement(j))+ke(i,j);
            K(currElement(j),currElement(i))=K(currElement(i),currElement(j));
            
        end
        fe(i)=2*element_area*FofXY(n)*dot(q.Weights,bipolyval(psi(i).fun,q.Points));
        F(currElement(i)) = F(currElement(i))+fe(i);
    end
    
    
    
    
    
end

%disp(K);
end

