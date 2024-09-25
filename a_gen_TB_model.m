function ef = a_gen_TB_model(para)
     th0 = para.FSInfo.th0;
     rotx = @(k1,k2,t) cos(t)*k1 - sin(t)*k2;
     roty = @(k1,k2,t) cos(t)*k2 + sin(t)*k1;
%    rotk = @(k,t) [rotx(k(1),k(2),t);roty(k(1),k(2),t)];
    if para.FSInfo.TBmodel == "Simple"
        para.FSInfo.t1 = 1;
        para.FSInfo.t2 = 1; 
        ef = @(kx,ky) ...
            - 2*para.FSInfo.t1*cos(rotx(kx,ky,th0)) ...
            - 2*para.FSInfo.t2*cos(roty(kx,ky,th0)) ...
            - para.FSInfo.mu;
    elseif para.FSInfo.TBmodel == "PdCoO2"
         para.FSInfo.t1 = 1;
        para.FSInfo.t2 = 0.14; 
        a = [1,0];
        b = [1/2,sqrt(3)/2];
        ef1 = @(kx,ky) ...
            -2*para.FSInfo.t1*(cos(a(1) * rotx(kx,ky,th0) + a(2) * roty(kx,ky,th0)) ...
            + cos(b(1) * rotx(kx,ky,th0) + b(2) * roty(kx,ky,th0)) ...
            + cos((a(1)-b(1)) * rotx(kx,ky,th0) + (a(2)-b(2)) * roty(kx,ky,th0)));
        ef2 = @(kx,ky) ... 
            -2*para.FSInfo.t2*(cos(a(1) * rotx(kx,ky,th0) + a(2) * roty(kx,ky,th0)).^2 ...
            + cos(b(1) * rotx(kx,ky,th0) + b(2) * roty(kx,ky,th0)).^2 ...
            + cos((a(1)-b(1)) * rotx(kx,ky,th0) + (a(2)-b(2)) * roty(kx,ky,th0)).^2);
        ef = @(kx,ky) ef1(kx,ky) + ef2(kx,ky) - para.FSInfo.mu;
    elseif para.FSInfo.TBmodel == "Bi2212"
        para.FSInfo.t1 = 1; 
        para.FSInfo.t2 = -0.136;
        para.FSInfo.t3 = 0.061;
        para.FSInfo.t4 = -0.017;
        ef1 = @(kx,ky) -2*para.FSInfo.t1*(cos(rotx(kx,ky,th0)) + cos(roty(kx,ky,th0)));
        ef2 = @(kx,ky) -4*para.FSInfo.t2*cos(rotx(kx,ky,th0)).*cos(roty(kx,ky,th0));
        ef3 = @(kx,ky) -2*para.FSInfo.t3*(cos(2*rotx(kx,ky,th0)) + cos(2*roty(kx,ky,th0)));
        ef4 = @(kx,ky) -2*para.FSInfo.t4*(cos(2*rotx(kx,ky,th0)).*cos(roty(kx,ky,th0)) + cos(2*roty(kx,ky,th0)).*cos(rotx(kx,ky,th0)));
        ef = @(kx,ky) ef1(kx,ky) + ef2(kx,ky) + ef3(kx,ky) + ef4(kx,ky) - para.FSInfo.mu;
    elseif para.FSInfo.TBmodel == "Cross"
        para.FSInfo.t1 = 0.3;
        ef = @(x,y) x.^2 + y.^2 - 2 * para.FSInfo.t1 * (rotx(x,y,th0).^4 + roty(x,y,th0).^4 - 6.*rotx(x,y,th0).^2.*roty(x,y,th0).^2)./(x.^2 + y.^2).^2 - 1 - para.FSInfo.mu;
    end
end