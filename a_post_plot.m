Vstress = Vstress';
nlines=size(Vq,1);
%nlines = 17;
cmap=hsv(nlines);
gmc_scan = 1;
gmr_scan = 0;
V_scan = 0;
R_scan = 1;
VV = [];
 
if gmc_scan
    for ii=1:nlines
        VV = [VV;max(abs(Vq(ii,:)))];
        if V_scan 
           plot(rot_angle/pi*180,Vq(ii,:),'LineWidth',4,'Color',cmap(ii,:),'DisplayName',['\gamma_{mc}=',num2str(gmc_array(ii),'%.4f')])
        elseif R_scan 
           plot(rot_angle/pi*180,Sxxq(ii,:)./Sxxbulk(ii,round(end/2)),'LineWidth',4,'Color',cmap(ii,:),'DisplayName',['\gamma_{mc}=',num2str(gmc_array(ii),'%.4f')])
        end
        hold on;
    end
elseif gmr_scan
     for ii=1:nlines
         if V_scan 
           plot(rot_angle/pi*180,Vq(ii,:),'-o','Color',cmap(ii,:),'DisplayName',['\gamma_{mr}=',num2str(gmr_array(ii),'%.4f')])
        elseif R_scan 
           plot(rot_angle/pi*180, Sxxq(ii,:)./Sxxbulk(ii,round(end/2)),'Color',cmap(ii,:),'DisplayName',['\gamma_{mr}=',num2str(gmr_array(ii),'%.4f')])
        end
        hold on;
     end
end
recolor
hold off;  