
gmc_array = 10.^(linspace(-2,2,20).');
%gmc_array = [0;0.1;1;5];
gmr_array = 1;
dress = 0;
Sxx = zeros(length(gmr_array),length(gmc_array),length(dress));
Phiys = [];
for kk = 1:length(dress)
    for ii = 1:length(gmr_array)
        for jj = 18:length(gmc_array)
               aux_progress(jj+(ii-1)*length(gmc_array)+(kk-1)*length(gmr_array)*length(gmc_array),length(gmc_array)*length(dress)*length(gmr_array),'*')
            if jj == 1
                para = a_para_init('aa',dress(kk),'gmr',gmr_array(ii),'gmc',gmc_array(1),'Ny',100,'Nth',600);
                para.hOld = para.hinit;
                para.hNew = para.hinit;
                para = a_cal_source(para);
            else
                para = a_para_renew(para,'aa',dress(kk),'gmr',gmr_array(ii),'gmc',gmc_array(jj));
            end
            para = a_sc_loop(para);
            para.SCInfo.Flag = 1;
            para.SCInfo.itr = 0;
            a_writehis(para);
            Sxx(ii,jj,kk) = para.result.Sxx;
            Phiys = [Phiys,trapz(para.y,para.src.Ey)];
        end
    end
end
cd(para.SavingRootPath)


