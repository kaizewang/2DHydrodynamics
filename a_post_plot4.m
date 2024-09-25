Vkm = a_peak_find(Vstress);
Vcm = a_peak_find(Vcol);
vfa = mean(sqrt(w.FSInfo.VFxy(:,1).^2 + w.FSInfo.VFxy(:,2).^2));


figure
plot(gmc_array(1:length(Vkm))/vfa,-Vkm,'marker','o','MarkerFaceColor','b')
hold on;
plot(gmc_array(1:length(Vkm))/vfa,Vcm,'Marker','o','MarkerFaceColor','r');
legend \Phi_{stress} \Phi_{mr}
pub_square_fig
xlabel('\gamma_{mc}')
ylabel('max(V)')