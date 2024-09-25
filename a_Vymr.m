gggg = [];  
gmr = 1;gmc = 0;  
for phi = linspace(0,pi/4,20)
  para = a_para_init('FSType',"TB",'TBmodel',"Bi2212",'mu', -0.82,'gmr',gmr,...
                    'gmc',gmc,'Ny',60,'Nth',1000,'FSrot_angle',phi,'Mitr',200);
%   para = a_para_init('FSType',"TB",'TBmodel',"Simple",'mu',-0.1,'gmr',gmr,...
%                     'gmc',gmc,'Ny',80,'Nth',140,'FSrot_angle',phi);
   w = para;
    w = a_cal_source(w);
    h = w.hNew;
    px = w.FSInfo.XY(:,1);
    vx = w.FSInfo.VFxy(:,1);
    vy = w.FSInfo.VFxy(:,2);
    A = w.FSInfo.ThAth(:,2);
     jy = w.src.fth(:,6);
    gggg = [gggg; -w.gmr/2*trapz(w.FSInfo.ThAth(:,1),vx.*sign(vy).*A)/trapz(w.th,A.*jy.^2)];
end