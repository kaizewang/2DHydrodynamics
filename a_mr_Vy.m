alpha = [0,linspace(0.01,0.8,100)];
alpha = 0.4;
phi = linspace(0,pi/4,100);
%phi = pi/8;
Vymr = [];
for ii = 1:length(alpha)
    for jj = 1:length(phi)
    w  = a_para_init('aa',alpha(ii),'save',0,'FSrot_angle',phi(jj),'gmr', 2.1544,'FSnRot',4,'Nth',1e3);
    w = a_cal_source(w);
    h = w.hNew;
    jy = w.src.fth(:,6);
    jx = w.src.fth(:,5);
    A = w.FSInfo.ThAth(:,2);
    xx = 2*A.*jx.*jy.^2.*exp(-w.gmr./2./abs(jy+1e-10)).*sinh(w.gmr.*1./2./(jy+1e-10))/w.gmr;
    tth = w.th(~isnan(xx));
    xx = xx(~isnan(xx));
    Vymr(ii,jj) = trapz(tth,xx)/trapz(w.th,A.*jy.^2);
    end
end
% %%
% for ii = 1:length(alpha)
%     for jj = 1
%     w  = a_para_init('aa',alpha(ii),'save',0,'FSrot_angle',phi(jj));
%     w = a_cal_source(w);
%     plot(w.FSInfo.VFxy(:,1),w.FSInfo.VFxy(:,2));
%     pause();
%     end
% end







        