time = datestr(now,'mmdd-HH-MM-SS');
rot_angle = linspace(0,pi/4,20).';
rot_angle = rot_angle(10);
gmr = 1;
gmc_array = linspace(0,5,10);
gmc_array = gmc_array(1);
mu_array = -0.9;
Phiy  = zeros(length(gmc_array),length(rot_angle));
results = [];
results.gmr = gmr;
results.gmc = gmc_array ;
results.mu = mu_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
for kk = 1:length(gmc_array)
    for ii = 1:length(mu_array)
        for jj = 1:length(rot_angle)
            if jj == 1 && kk==1
                para = a_para_init('mu',mu_array(ii),'gmr',gmr,...
                    'gmc',gmc_array(kk),'Ny',100,'Nth',140,'FSrot_angle',rot_angle(1),'jobdis','gmcjobsTB-Bi2212',...
                    'TS',time,'TBmodel',"Bi2212");
            else
                para = a_para_renew(para,'FSrot_angle',rot_angle(jj),'gmc',gmc_array(kk));
            end
            para = a_cal_source(para);
            para = a_sc_loop(para);
            a_writehis(para);
            if mod(kk,2) == 0
                Phiy(kk,end + 1 -jj) = trapz(para.y,para.src.Ey);
            else
                Phiy(kk,jj) = trapz(para.y,para.src.Ey);
            end
            results.Vy = Phiy;
            save(strcat(para.Xfile_name2,'/results.mat'),"results","-v7.3");
        end
        rot_angle = rot_angle(end:-1:1);
    end
end

