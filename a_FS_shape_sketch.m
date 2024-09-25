  para = a_para_init('FSType',"Geo",'aa',0.8,'gmr',1,...
                    'gmc',0,'Ny',10,'Nth',1e3,'FSrot_angle',0,'jobdis','C4gmcjobs',...
                   'save',0);
  figure;
  %plot(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2));
patch(para.FSInfo.XY(:,1),para.FSInfo.XY(:,2),'b','Facealpha',0.1)
axis equal
grid off
set(gca,'XColor', 'none','YColor','none')
set(gca, 'color', 'none');