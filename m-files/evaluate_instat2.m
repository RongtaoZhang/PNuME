function [elemat,elevec] = evaluate_instat(elenodes,gpx,gpw,elesol,eleosol,timInt_m,timestep,theta,firststep)
    elemat=zeros(4,4);
    rhs = zeros(4,4);
    lamda=48;
    p=7800;
    c=452;
    M=zeros(4,4);
    B=zeros(4,4);
    RHS = zeros(4,1)
    for i=1:4
       for j=1:4
          Mij=0;
          Bij=0;
          for k=1:size(gpw)
              xi=gpx(k,1);
              eta=gpx(k,2);
              deriv=linquadderivref(xi,eta);
              val=linquadref(xi,eta);
              [~,detJ,invJ]=getJacobian(elenodes,xi,eta);
              Ni=val(i,:);
              Nj=val(j,:);
              dNi=deriv(i,:)*invJ;  %gNv gradient of N
              dNj=deriv(j,:)*invJ;  
              Mij=Mij+p*c*Ni*Nj*detJ*gpw(k);
              Bij=Bij+lamda*dot(dNi,dNj)*detJ*gpw(k);
          end
          M(i,j)=Mij;
          B(i,j)=-Bij;
          C = 0;
          if timInt_m==1
                [LHS(i,j),rhs(i,j)] = OST(theta,timestep,M(i,j),[B(i,j) B(i,j)],[C C],elesol(j));
          elseif timInt_m==2
                [LHS,RHS] = AB2(timestep,M,B,C,[elesol(j),eleosol(j)]);
          elseif timInt_m==3
                [LHS,RHS] = AM3(timestep,M,B,C,[elesol(j),eleosol(j)]);
          elseif timInt_m==4
                [LHS,RHS] = BDF2(timestep,M,B,C,[elesol(j),eleosol(j)]);
          else
                disp('false')
          end
          RHS(i)= RHS(i)+rhs(i,j);
       end
    % [LHS(i,j),RHS(i)] = OST(0.66,1000,M(i,j),[B(i,j),B(i,j)],[0,0],elesol(i))
    end
    elemat=LHS;
    elevec=RHS;
end