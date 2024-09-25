%x = a_para_init('FSType',"TB",'TBmodel',"Bi2212",'mu',-0.82,'save',0,'Nth',1e3,'Ny',1);
%x = a_para_init('FSType',"TB",'TBmodel',"PdCoO2",'mu',0,'save',0,'Nth',1e3,'Ny',1);
%x = a_para_init('FSType',"TB",'TBmodel',"Simple",'mu',-0.1,'save',0,'Nth',2e4,'Ny',1);
x = a_para_init('FSType',"TB",'TBmodel',"Cross",'mu',0,'save',0,'Nth',1e3,'Ny',1);
VF = x.FSInfo.VFxy;
kF = x.FSInfo.XY;
th = x.FSInfo.ThAth(:,1);
wk = (sum(VF.*kF,2)).^2./(sum(VF.^2,2).*sum(kF.^2,2));
polarplot(th,wk)