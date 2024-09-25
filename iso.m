time = datestr(now,'mmdd-HH-MM-SS');
dress_array = 0;
rot_angle = 0;
gmr_array = [5,1,0.5,0.2,0.1];
gmc_array = 10.^linspace(-2,2,100);
gmc_array = linspace(1e-2,1e2,100);
Phiy  = zeros(length(gmr_array),length(gmc_array));
results = [];
results.gmr = gmr_array;
results.gmc = gmc_array ;
results.dress = dress_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
result.Sxx = Phiy;
Sxx = Phiy;
for pp = 1:length(gmr_array)
    for kk = 1:length(gmc_array)
        for ii = 1:length(dress_array)
            for jj = 1:length(rot_angle)
                iitr = (pp - 1) * length(gmc_array) + kk;
                disp(['finishing percentage:',num2str(iitr/length(gmc_array)...
                    /length(gmr_array)*100,3),'%']);
                if kk==1
                    para = a_para_init('FSType',"Geo",'aa',dress_array(ii),'gmr',gmr_array(pp),...
                        'gmc',gmc_array(kk),'Ny',100,'Nth',140,'FSrot_angle',rot_angle(1),'jobdis','isojob',...
                        'TS',time);
                else
                    para = a_para_renew(para,'gmc',gmc_array(kk));
                end
                para = a_cal_source(para);
                para = a_sc_loop(para);
                para = a_symfix(para);
                a_result_saving(para);
                a_writehis(para);
                Phiy(pp,kk) = trapz(para.y,para.src.Ey);
                Sxx(pp,kk) = para.result.Sxx;
                results.Vy = Phiy;
                results.Sxx = Sxx;
                save(strcat(para.Xfile_name2,'/results.mat'),"results","-v7.3");
            end
        end
    end
end

