function [K,F,M] = assemble1D(KofX,BofX,FofX,ke,fe,ae,nodelist)
    p=evalin('base','p'); %p=degree of poly elements
    nNodes=evalin('base','nNodes'); %number of nodes
    
    %preallocate kn,fn,he,K,F
    kn=zeros(p+1,p+1); 
    fn=zeros(p+1,1);
    he=0;  
    K=zeros(nNodes);
    F=zeros(nNodes,1);
    M=zeros(nNodes);
    
    c=1;
    alpha=0; %upwinding parameter
    
    cnt = 1;
    %loop through K, assembling sub-matrices kn 
    for i=1:+p:nNodes-1
        he=nodelist.Points(i+p)-nodelist.Points(i);
        KofX(cnt) = KofX(cnt)+0.5*alpha*c*he;
        kn=(2/he)*KofX(cnt)*ke.k+(he/2)*BofX(cnt)*ke.b;%+ae;
        %disp(kn);
        
        %sub1,sub2 are the nodes that each kn corresponds to
        sub1=nodelist.ConnectivityList(cnt,1);
        sub2=nodelist.ConnectivityList(cnt,2);
        
        %assemble K with kn's
        K(sub1:sub2,sub1:sub2)=K(sub1:sub2,sub1:sub2)+kn;

        fn=(he/2)*FofX(cnt)*fe;  
        
        %assemble F with fn's
        F(sub1:sub2,1)=F(sub1:sub2,1)+fn;     
        
        M(sub1:sub2,sub1:sub2)=M(sub1:sub2,sub1:sub2)+(he/2)*ke.b;    
        
        cnt=cnt+1;
    end 
    
end

