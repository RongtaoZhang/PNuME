function [dbcsysmat,dbcrhs] = assignDBC(sysmat,rhs,dbc)
    %dbc是一个两列的矩阵，第一列代表节点位置，第二列代表该节点对应的边界温度
    a=size(dbc,1);
    dbcsysmat = sysmat;
    dbcrhs = rhs;
    %返回该矩阵的行数
    for i=1:a
        dbcsysmat(dbc(i,1),:)=0;
        %有边界温度的这一行先全部用零替换
        dbcsysmat(dbc(i,1),dbc(i,1))=1;
        %dbc温度所在的节点用1替换
        dbcrhs(dbc(i,1))=dbc(i,2);
        %把dbc的值放入rhs
    end
end