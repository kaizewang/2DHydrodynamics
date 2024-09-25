time = datestr(now,'mmdd-HH-MM-SS');
mu_array = -0.82;
rot_angle = linspace(0,pi/4,15).';
gmr = 1;
gmc_array = linspace(0,20,20).';
Phiy  = zeros(length(gmc_array),length(rot_angle));
results = [];
results.gmr = gmr;
results.gmc = gmc_array ;
results.dress = dress_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
result.Sxx = Phiy;
Sxx = Phiy;
for kk = 1:length(gmc_array)
    for ii = 1:length(mu_array)
        for jj = 1:length(rot_angle)
            iitr = (kk - 1) * length(rot_angle) + jj;
            disp(['finishing percentage:',num2str(iitr/length(rot_angle)...
                /length(gmc_array)*100,3),'%']);
            if jj == 1 && kk==1
                para = a_para_init('FSType',"TB",'TBmodel',"Bi2212",'mu',mu_array(ii),'gmr',gmr,...
                    'gmc',gmc_array(kk),'Ny',60,'Nth',200,'FSrot_angle',rot_angle(1),'jobdis','diamond',...
                    'TS',time,'Mitr',200);
            else
                para = a_para_renew(para,'FSrot_angle',rot_angle(jj),'gmc',gmc_array(kk));
            end
            para = a_cal_source(para);
            para = a_sc_loop(para);
            if jj == 1||jj==length(rot_angle)
                para = a_symfix(para);
                a_result_saving(para);
            end
            a_writehis(para);
            if mod(kk,2) == 0
                Phiy(kk,end + 1 -jj) = trapz(para.y,para.src.Ey);
                Sxx(kk,end + 1 -jj) = para.result.Sxx;
            else
                Phiy(kk,jj) = trapz(para.y,para.src.Ey);
                Sxx(kk,jj) = para.result.Sxx;
            end
            results.Vy = Phiy;
            results.Sxx = Sxx;
            save(strcat(para.Xfile_name2,'/results.mat'),"results","-v7.3");
        end
        rot_angle = rot_angle(end:-1:1);
    end
end

