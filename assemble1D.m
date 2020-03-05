function [K,F] = assemble1D(KofX,BofX,FofX,ke,fe,nodelist)
    p=evalin('base','p'); %p=degree of poly elements
    nNodes=evalin('base','nNodes'); %number of nodes
    
    %preallocate kn,fn,he,K,F
    kn=zeros(p+1,p+1); 
    fn=zeros(p+1,1);
    he=0;  
    K=zeros(nNodes);
    F=zeros(nNodes,1);
    
    %loop through K, assembling sub-matrices kn 
    for i=1:+p:nNodes-1
        he=nodelist.Points(i+1)-nodelist.Points(i);
        kn=(2/he)*KofX(i)*ke.k+(he/2)*BofX(i)*ke.b;
        
        %sub1,sub2 are the nodes that each kn corresponds to
        sub1=nodelist.ConnectivityList(i,1);
        sub2=nodelist.ConnectivityList(i,2);
        
        %assemble K with kn's
        K(sub1:sub2,sub1:sub2)=K(sub1:sub2,sub1:sub2)+kn;

        fn=(he/2)*FofX(i)*fe;  
        
        %assemble F with fn's
        F(sub1:sub2,1)=F(sub1:sub2,1)+fn;       
    end 
end

