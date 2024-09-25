phi = linspace(0,pi/4,20);
Vymr = [];
gmr_array = 1;
for ii = 1:length(gmr_array)
    for jj = 1:length(phi)
    w = a_para_init('FSType',"TB",'TBmodel',"Simple",'mu',-0.1,'gmr',gmr_array(ii),...
                    'gmc',0,'Ny',60,'Nth',200,'FSrot_angle',phi(jj),'jobdis','Squarephitest',...
                     'Mitr',200);
    w = a_cal_source(w);
    h = w.hNew;
    jy = w.src.fth(:,6);
    jx = w.src.fth(:,5);
    A = w.FSInfo.ThAth(:,2);
    th = w.FSInfo.ThAth(:,1);
    py = w.FSInfo.XY(:,2);
    Vymr(ii,jj) = trapz(jx.*A.*py./abs(jy+1e-10));
    end
end