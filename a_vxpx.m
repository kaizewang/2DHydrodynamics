alpha = [0,linspace(0.01,0.8,100)];
phi = pi/8;
Vymr = [];
gggg = [];
for ii = 1:length(alpha)
    for jj = 1:length(phi)
    w  = a_para_init('aa',alpha(ii),'save',0,'FSrot_angle',phi(jj),'gmr',1,'FSnRot',4,'Nth',3e3);
    w = a_cal_source(w);
    h = w.hNew;
    px = w.FSInfo.XY(:,1);
    vx = w.FSInfo.VFxy(:,1);
    vy = w.FSInfo.VFxy(:,2);
    A = w.FSInfo.ThAth(:,2);
     jy = w.src.fth(:,6);
    gggg(ii) = -w.gmr/2*trapz(w.FSInfo.ThAth(:,1),vx.*sign(vy).*A)/trapz(w.th,A.*jy.^2);
    end
end
%  plot(alpha,ggg)
 figure
 plot(alpha,gggg)