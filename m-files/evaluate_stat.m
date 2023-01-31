function [elemat,elevec]=evaluate_stat(elenodes,gpx,gpw)
    elemat=zeros(4,4);
    %按照公式右边，求出来的是一个一个的值，然后把一个一个的值代入这个4x4的零矩阵
    lamda=48;
    %一个常数，题目会给的
    for i=1:4
       for j=1:4
           s=0;%求的这些值是一个一个的累加，所以需要设置一个初值
           for k=1:size(gpw)%要循环所有的高斯点
               xi=gpx(k,1);
               eta=gpx(k,2);
               deriv=linquadderivref(xi,eta);
              [~,detJ,invJ]=getJacobian(elenodes,xi,eta);
              dNi=deriv(i,:)*invJ;
              dNj=deriv(j,:)*invJ;
              s=s+lamda*dot(dNi,dNj)*detJ*gpw(k);
           end
           elemat(i,j)=s;
      end
    end
    elevec=zeros(4,1);
end