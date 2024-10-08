nlines=size(Vq,2);
%nlines = 18;
cmap=hsv(nlines);
gmc_scan = 1;
gmr_scan = 0;
V_scan = 1;
R_scan = 0;
if gmc_scan
    for ii=1:nlines
        if V_scan 
           plot(gmc_array(1:size(Vq,1)),Vq(:,ii),'-o','Color',cmap(ii,:),'DisplayName',['rot=',num2str(rot_angle(ii)/pi*180,'%.4f')])
        elseif R_scan 
           plot(gmc_array,Sxxq(1:length(gmc_array),ii),'-o','Color',cmap(ii,:),'DisplayName',['rot=',num2str(rot_angle(ii)/pi*180,'%.4f')])
        end
        hold on;
    end
elseif gmr_scan
     for ii=1:nlines
         if V_scan 
           plot(gmr_array,Vq(:,ii),'-o','Color',cmap(ii,:),'DisplayName',['rot=',num2str(rot_angle(ii)/pi*180,'%.4f')])
        elseif R_scan 
           plot(gmr_array,1./Sxxq(:,ii),'-o','Color',cmap(ii,:),'DisplayName',['rot=',num2str(rot_angle(ii)/pi*180,'%.4f')])
        end
        hold on;
     end
end

hold off;  