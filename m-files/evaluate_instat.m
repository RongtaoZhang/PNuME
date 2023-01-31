% Fkt. XX
function [elemat, elevec] = evaluate_instat(elenodes, gpx, gpw, elesol, eleosol, timInt_m, timestep, theta, firststep)
% elenodes: Knotenpositionen; elesol: Lösung Zeitschritt n-Spaltenvektor;
% eleosol: Lösung Zeitschritt (n-1)-Spaltenvektor; 
% timInt_m: Zeitintegrationsverfahren, 1=OST, 2=AB2, 3=AM3, 4=BDF2;
% timestep: Zeitschrittlänge delta_t; theta: theta für OST;
% firststep: erste Zeitschritt?;
% Rückgabewert: Elementmatrix A(e), Elementvektor f(e)

elemat = zeros(4, 4);
elevec = zeros(4, 1);
rhs = zeros(4, 4);
lambda = 48;
rho = 7800;
c = 452;

for i = 1:4
    for j = 1:4
        Mij = 0;
        Bij = 0;
        for k = 1:size(gpw)
            xi = gpx(k, 1);
            eta = gpx(k, 2);
            dN = linquadderivref(xi, eta);
            N = linquadref(xi, eta);
            [~, detJ, invJ] = getJacobian(elenodes, xi, eta);
            Ni = N(i);
            Nj = N(j);
            dNi = dN(i, :) * invJ;
            dNj = dN(j, :) * invJ;
            Mij = Mij + rho * c * Ni * Nj * detJ * gpw(k);
            Bij = Bij + lambda * dNi * dNj' * detJ * gpw(k);
        end
        
        C = 0;
        if firststep == 1
            [elemat(i, j), rhs(i, j)] = OST(theta, timestep, Mij, [-Bij, -Bij], [C, C], elesol(j));
        else
            switch timInt_m
                case 1
                    [elemat(i, j), rhs(i, j)] = OST(theta, timestep, Mij, [-Bij, -Bij], [C, C], elesol(j));
                case 2
                    [elemat(i, j), rhs(i, j)] = AB2(timestep, Mij, [-Bij, -Bij], [C, C], [elesol(j), eleosol(j)]);
                case 3
                    [elemat(i, j), rhs(i, j)] = AM3(timestep, Mij, [-Bij, -Bij, -Bij], [C, C, C], [elesol(j), eleosol(j)]);
                case 4
                    [elemat(i, j), rhs(i, j)] = BDF2(timestep, Mij, -Bij, C, [elesol(j), eleosol(j)]);
                otherwise
                    disp('falsches Zeitintegrationsverfahren');
            end
        end
        elevec(i) = elevec(i) + rhs(i, j);
    end
end

end