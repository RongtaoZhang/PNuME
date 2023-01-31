% Modultests
function mtest()
clc; clear; close all;

[J, detJ, invJ] = getJacobian([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577);
[ostL, ostR] = OST(0.5, 0.2, [1.1], [1.4, 1.5], [1.7, 1.8], [2.0]);
[ab2L, ab2R] = AB2(0.2, [1.1], [1.5, 1.6], [1.8, 1.9], [2.0, 2.1]);
[am3L, am3R] = AM3(0.2, [1.1], [1.4, 1.5, 1.6], [1.7, 1.8, 1.9], [2.0, 2.1]);
[bdf2L, bdf2R] = BDF2(0.2, [1.1], [1.4], [1.7], [2.0, 2.1]);
[elemat, elevec] = evaluate_stat([0, 0; 1, 0; 1, 2; 0, 2], gx2dref(3), gw2dref(3));
[sysmat, sysvec] = assemble([1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12; 13, 14, 15, 16], [17; 18; 19; 20], eye(5,5), ones(5,1), [5, 3, 1, 2]);
[sysmat_dbc, sysvec_dbc] = assignDBC([12, 12, 10, 0, 9; 15, 17, 14, 0, 13; 7, 8, 7, 0, 5; 0, 0, 0, 1, 0; 3, 4, 2, 0, 2], [20; 21; 19; 1; 18], [2, -7; 5, -2]);
[elemat_in, elevec_in] = evaluate_instat([0,0;1,0;1,2;0,2],gx2dref(3),gw2dref(3),[1;2;3;4],[0;0;0;0],1,1000,0.66,1);

testfunctions = {... %Funktion Name, Funktion benutzt, Output, Tolerance
    {'Fkt A:        facultaet_0', factorial(0), 1.0, 1e-12}, ...
    {'Fkt A:        facultaet_5', factorial(5), 120.0, 1e-12}, ...
    {'Fkt I:        linquadref(0,0)', linquadref(0,0), [0.25;0.25;0.25;0.25], 1e-12}, ...
    {'Fkt I:        linquadref(0.577,-0.577)', linquadref(0.577,-0.5777), ...
    [0.166841775;0.622008225;0.166491775;0.044658225000000], 1e-12}, ...
    {'Fkt II:       linquadref(0,0)', linquadderivref(0,0), ...
    [-0.25 -0.25;0.25 -0.25;0.25 0.25;-0.25 0.25], 1e-12}, ...
    {'Fkt II:       linquadref(0.577,-0.577)', linquadderivref(0.577,-0.577), ...
    [-0.39425 -0.10575;0.39425 -0.39425;0.10575 0.39425;-0.10575 0.10575], 1e-12}, ...
    {'Fkt III:      gx(3)', gx(3), [-0.774596669241483, 0, 0.774596669241483], 1e-12}, ...
    {'Fkt IV:       gw(3)', gw(3), [0.55555555555555, 0.888888888888889, 0.55555555555555], 1e-12}, ...
    {'Fkt V:        gx2dref(1)', gx2dref(1), [0.0, 0.0], 1e-12}, ...
    {'Fkt V:        gx2dref(2)', gx2dref(2), [-0.577350269189626, -0.577350269189626;...
    -0.577350269189626, 0.577350269189626;  0.577350269189626, -0.577350269189626; ...
     0.577350269189626, 0.577350269189626], 1e-12}, ...
    {'Fkt V:        gx2dref(3)', gx2dref(3),  [-0.774596669241483, -0.774596669241483; ...
    -0.774596669241483, 0; -0.774596669241483, 0.774596669241483; 0, -0.774596669241483; ...
    0, 0; 0, 0.774596669241483; 0.774596669241483, -0.774596669241483; 0.774596669241483, 0; ...
    0.774596669241483, 0.774596669241483], 1e-12}, ...
    {'Fkt VI:       gw2dref(1)', gw2dref(1), [4.0], 1e-12}, ...
    {'Fkt VI:       gw2dref(2)', gw2dref(2), [1.0; 1.0; 1.0; 1.0], 1e-12}, ...
    {'Fkt VI:       gw2dref(3)', gw2dref(3), [0.308642; 0.493827; 0.308642; ...
    0.493827; 0.790123; 0.493827; 0.308642; 0.493827; 0.308642], 1e-12}, ...     % tol = 1e-6
    {'Fkt VII:      getxPos([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577)', ...
    getxPos([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577), [3.577; 1.37826775], 1e-12}, ...
    {'Fkt VIII:     getJacobian([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577), J', ...
    J,  [1.0, 0; 0.10575, 0.89425], 1e-12}, ...
    {'Fkt VIII:     getJacobian([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577), detJ', ...
    detJ,  0.89425, 1e-12}, ...
    {'Fkt VIII:     getJacobian([2, 1; 4, 1; 4, 3; 2, 2], 0.577, -0.577), invJ', ...
    invJ,  [1.0, 0; -0.1182555, 1.1182555], 1e-12}, ...                         % tol = 1e-7
    {'Fkt IX:       OST(0.5, 0.2, [1.1], [1.4, 1.5], [1.7, 1.8], [2.0]), LHS', ...
    ostL, 0.96, 1e-12}, ...
    {'Fkt IX:       OST(0.5, 0.2, [1.1], [1.4, 1.5], [1.7, 1.8], [2.0]), RHS', ...
    ostR, 2.85, 1e-12}, ...
    {'Fkt X:        AB2(0.2, [1.1], [1.5, 1.6], [1.8, 1.9], [2.0, 2.1]), LHS', ...
    ab2L, 1.1, 1e-12}, ...
    {'Fkt X:        AB2(0.2, [1.1], [1.5, 1.6], [1.8, 1.9], [2.0, 2.1]), RHS', ...
    ab2R, 3.114, 1e-12}, ...
    {'Fkt XI:       AM3(0.2, [1.1], [1.4, 1.5, 1.6], [1.7, 1.8, 1.9], [2.0, 2.1]), LHS', ...
    am3L, 0.983333333333333, 1e-12}, ...
    {'Fkt XI:       AM3(0.2, [1.1], [1.4, 1.5, 1.6], [1.7, 1.8, 1.9], [2.0, 2.1]), RHS', ...
    am3R, 2.894, 1e-12}, ...
    {'Fkt XII:      BDF2(0.2, [1.1], [1.4], [1.7], [2.0, 2.1]), LHS', ...
    bdf2L, 1.37, 1e-12}, ...
    {'Fkt XII:      BDF2(0.2, [1.1], [1.4], [1.7], [2.0, 2.1]), RHS', ...
    bdf2R, 3.585, 1e-12}, ...
    {'Fkt XIV:      solveGauss([10.0, 2, 1; 3, 4, 4; 1, 8, 4], [1; 1; 2])', solveGauss([10.0, 2, 1; 3, 4, 4; 1, 8, 4], [1; 1; 2]), ...
    [0.051282051282051; 0.275641025641026; -0.064102564102564], 1e-12}, ...
    {'Fkt XV:       solveG([10.0, 2.0, 10.0; 2.0, 40.0, 8.0; 10.0, 8.0, 60.0], [1.0; 1.0; 2.0], [0.0; 0.0; 0.0], 1e-7, 1000)', ...
    solveG([10.0, 2.0, 10.0; 2.0, 40.0, 8.0; 10.0, 8.0, 60.0], [1.0; 1.0; 2.0], [0.0; 0.0; 0.0], 1e-7, 1000), ...
    [0.078600816156673; 0.017489712225719; 0.017901236448326], 1e-12}, ...
    {'Fkt XVI:      solveCG([10.0, 2.0, 10.0; 2.0, 40.0, 8.0; 10.0, 8.0, 60.0], [1.0; 1.0; 2.0], [0.0; 0.0; 0.0], 1e-7, 1000)', ...
    solveCG([10.0, 2.0, 10.0; 2.0, 40.0, 8.0; 10.0, 8.0, 60.0], [1.0; 1.0; 2.0], [0.0; 0.0; 0.0], 1e-7, 1000), ...
     [0.078600823045267; 0.017489711934156; 0.017901234567901], 1e-12}, ...
    {'Fkt XVII:     evaluate_stat([0, 0; 1, 0; 1, 2; 0, 2], gx2dref(3), gw2dref(3)), elemat', elemat, ...
    [40.000000000000000,-28.000000000000004,-20.000000000000000,7.999999999999998;
     -28.000000000000004,40.000000000000007,8.000000000000000,-20.000000000000000;
     -20.000000000000000,8.000000000000000,39.999999999999993,-28.000000000000000;
     7.999999999999998,-20.000000000000000,-28.000000000000000,40.000000000000000], 1e-12}, ...
    {'Fkt XVII:     evaluate_stat([0, 0; 1, 0; 1, 2; 0, 2], gx2dref(3), gw2dref(3)), elevec', elevec, ...
    [0; 0; 0; 0], 1e-12}, ...
    {'Fkt XVIII:    assemble([1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12; 13, 14, 15, 16], [17; 18; 19; 20], eye(5,5), ones(5,1), [5, 3, 1, 2]), sysmat', ...
    sysmat, [12,12,10,0,9;15,17,14,0,13;7,8,7,0,5;0,0,0,1,0;3,4,2,0,2], 1e-12}, ...
    {'Fkt XVIII:    assemble([1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12; 13, 14, 15, 16], [17; 18; 19; 20], eye(5,5), ones(5,1), [5, 3, 1, 2]), rhs', ...
    sysvec, [20;21;19;1;18], 1e-12}, ...
    {'Fkt XIX:      assignDBC([12, 12, 10, 0, 9; 15, 17, 14, 0, 13; 7, 8, 7, 0, 5; 0, 0, 0, 1, 0; 3, 4, 2, 0, 2], [20; 21; 19; 1; 18], [2, −7; 5, −2]), sysmat', ...
    sysmat_dbc, [12,12,10,0,9;0,1,0,0,0;7,8,7,0,5;0,0,0,1,0;0,0,0,0,1], 1e-12}, ...
    {'Fkt XIX:      assignDBC([12, 12, 10, 0, 9; 15, 17, 14, 0, 13; 7, 8, 7, 0, 5; 0, 0, 0, 1, 0; 3, 4, 2, 0, 2], [20; 21; 19; 1; 18], [2, −7; 5, −2]), rhs', ...
    sysvec_dbc, [20;-7;19;1;-2], 1e-12}, ...
    {'Fkt XX:       evaluate_instat([0,0;1,0;1,2;0,2],gx2dref(3),gw2dref(3),[1;2;3;4],[0;0;0;0],1,1000,0.66,1), elemat', elemat_in, ...
    [809866.6666666666,373253.3333333334,182666.6666666667,397013.3333333334;
     373253.3333333334,809866.6666666669,397013.3333333334,182666.6666666667;
     182666.6666666667,397013.3333333334,809866.6666666667,373253.3333333334;
     397013.3333333334,182666.6666666667,373253.3333333334,809866.6666666666], 1e-12}, ...
    {'Fkt XX:       evaluate_instat([0,0;1,0;1,2;0,2],gx2dref(3),gw2dref(3),[1;2;3;4],[0;0;0;0],1,1000,0.66,1), elevec', ...
    elevec_in, [3736426.6666666665;3918693.3333333335;4895306.6666666670;5077573.3333333321], 1e-12}, ...
    };

for i = 1 : numel(testfunctions)
    if abs(testfunctions{i}{2} - testfunctions{i}{3}) <= testfunctions{i}{4}
        fprintf('%s:     Testing function, <%s> ... passed (= %s, tol = %s)!\n', ...
            num2str(i, '%03d'), testfunctions{i}{1}, ...
            mat2str(testfunctions{i}{2}), mat2str(testfunctions{i}{4}));
    else
        fprintf(2, ['%s: !!! Testing function, <%s> ... ' ...
            'failed (= %s ～= %s, diff = %s)！\n'], ...
            num2str(i, '%03d'), testfunctions{i}{1}, ...
            mat2str(testfunctions{i}{2}), mat2str(testfunctions{i}{3}), ...
            mat2str(testfunctions{i}{3}-testfunctions{i}{2}));
    end
end

end