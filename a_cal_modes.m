function para1 = a_cal_modes(para)
    h = para.hOld;
    y = para.y;
    th = para.th;
    A = para.FSInfo.ThAth(:,2);
    Y0 = para.src.fth(:,2);
    Yx = para.src.fth(:,3);
    Yy = para.src.fth(:,4);
    jx = para.src.fth(:,5);
    jy = para.src.fth(:,6);
    h0 = trapz(th.',(A.*Y0).'.*h,2); 
    para.HydroModes_order = "h0-hx-hy";
    para.HydroModes(:,1) = h0;
    hx = trapz(th.',(A.*Yx).'.*h,2); 
    para.HydroModes(:,2) = hx;
    hy = trapz(th.',(A.*Yy).'.*h,2); 
    para.HydroModes(:,3) = hy;
    [hdth,hdy] = gradient(h,th,y);
    helper1 = trapz(th.',(A.*jy.^2).'.*hdy,2);
    helper2 = para.B*trapz(th.',(A.*para.Bdel.*jy).'.*hdth,2);
    helper3 = para.g*trapz(th.',(A.*jy).'.*h,2);
    temp1 = trapz(th,A.*jy.*Yx);
    temp2 = trapz(th,A.*jy.*Yy);
    temp3 = trapz(th,A.*jy.^2);
    para.src.EyOld = para.src.Ey;
    para.src.Ey = (helper1 + helper2 + helper3 - ...
        para.gmc * hx * temp1 - para.gmc * hy * temp2)/temp3; 
    para.src.S = kron(para.Ex*ones(size(y)),jx.') +... 
    kron(para.src.Ey,jy.') + para.g*kron(h0,Y0.') + para.gmc*(...
    kron(hx,Yx.') + kron(hy,Yy.'));
    para1 = para;
end