gmc_array = [10.^(linspace(-2,1,20))';10.^(linspace(1.1,3,40))'];
gmr_array = [0.2;5;10];
dress = 0;
Sxx = zeros(length(gmr_array),length(gmc_array),length(dress));
Phiys = zeros(length(gmr_array),length(gmc_array),length(dress));
for kk = 1:length(dress)
    for ii = 1:length(gmr_array)
        for jj = 1:length(gmc_array)
            %aux_progress(jj+(ii-1)*length(gmc_array)+(kk-1)*length(gmr_array)*length(gmc_array),length(gmc_array)*length(dress)*length(gmr_array),'*')
            clc;
            disp(['finishing percentage:',num2str((jj+(ii-1)*length(gmc_array)+(kk-1)*length(gmr_array)*length(gmc_array))/length(gmc_array)/length(dress)/length(gmr_array)/(0.01),3),'%']);
            if jj == 1
                para = a_para_init('aa',dress(kk),'gmr',gmr_array(ii),'gmc',gmc_array(1),'Ny',100,'Nth',100,'jobdis','gmc_circ');
                para.hOld = para.hinit;
                para.hNew = para.hinit;
                para = a_cal_source(para);
            else
                para = a_para_renew(para,'aa',dress(kk),'gmr',gmr_array(ii),'gmc',gmc_array(jj));
            end
            para = a_sc_loop(para);
            a_writehis(para);
            Sxx(ii,jj,kk) = para.result.Sxx;
            Phiys(ii,jj,kk) = trapz(para.y,para.src.Ey);

        end
    end
end
res.Sxx = Sxx;
res.gmc = gmc_array;
res.gmr = gmr_array;
res.dress = dress;
res.Vy = Phiy;
save(['../../../TwoD_DATA_V4/',para.time,'-',para.jobdis,'/res.mat'],"res");