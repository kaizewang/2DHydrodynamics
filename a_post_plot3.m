Vkm = a_peak_find(Vstress);
Vcm = a_peak_find(Vcol);
VBm = a_peak_find(VB);
Vgm1 = a_peak_find(Vgmc1);
Vgm2 = a_peak_find(Vgmc2);
figure
plot(gmc_array(1:length(Vkm)),Vkm,'-o',gmc_array(1:length(Vkm)),Vgm2,'-o',...
    gmc_array(1:length(Vkm)),Vgm1,'-o',gmc_array(1:length(Vkm)),VBm,'-o',...
    gmc_array(1:length(Vkm)),Vcm,'-o');
legend kinetic 'hydro yy' 'hydro xx' 'magnetic' 'J_y current'
pub_square_fig
xlabel('\gamma_{mc}')
ylabel('max(V)')
