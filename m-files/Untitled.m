format long;
elenodes = [0,0;3,0;3,4;0,2];
elesol = [15;0;0;0];
eleosol = [15;0;0;0];
timestep = 0.2;
t = 0:timestep:3;
dbc = [1,15;2,0];
theta = 1;
firststep= 1;
T = [15;0;0;0];
for i = 1:length(t)-1
   if i > 1
      firststep = 0; 
   end
   [elemat,elevec] = evaluate_instat2(elenodes,gx2dref(2),gw2dref(2),elesol,eleosol,timestep,theta,firststep);
   
   [sysmat,rhs]=assignDBC2(elemat,elevec,dbc);
   T=sysmat\rhs;
   if i == 1
       rhs
   end
   eleosol = elesol;
   elesol = T;
end
T
function [sysmat,rhs] = assignDBC2(sysmat,rhs,dbc)
    for i = 1:size(dbc,1)
        sysmat(dbc(i,1),:) = 0;
        sysmat(dbc(i,1),dbc(i,1)) = 1;
        rhs(dbc(i,1)) = dbc(i,2);
    end
end
function [elemat,elevec] = evaluate_instat2(elenodes,gpx,gpw,elesol,eleosol,timestep,theta,firststep)
    elemat = zeros(4,4);
    elevec = zeros(4,1);
    rhs = zeros(4,4);
    for i = 1:4
       for j = 1:4 
          Mij = 0;
          Bij = 0;
          for k = 1:length(gpw)
             x = gpx(k,1);
             eta = gpx(k,2);
             dN = linquadderivref(x,eta);
             N = linquadref(x,eta);
             [~,detJ,invJ] = getJacobian(elenodes,x,eta);  
             Ni = N(i);
             Nj = N(j);
             dNi = dN(i,:)*invJ;
             dNj = dN(j,:)*invJ;
             Mij = Mij + Ni*Nj*detJ*gpw(k);
             Bij = Bij +0.7*dNi*dNj'*detJ*gpw(k);
          end
          C = 0;
          if firststep
                     [elemat(i, j), rhs(i, j)] = OST(theta, timestep, Mij, [-Bij, -Bij], [C, C], elesol(j));
          else
                [elemat(i, j), rhs(i, j)] = OST(theta, timestep, Mij, [-Bij, -Bij], [C, C], elesol(j));
%                      [elemat(i, j), rhs(i, j)] = AB2(timestep, Mij, [-Bij, -Bij], [C, C], [elesol(j), eleosol(j)]);
          end
          elevec(i) = elevec(i) + rhs(i, j);
       end
    end
end