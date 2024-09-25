time = datestr(now,'mmdd-HH-MM-SS');
mu_array = 0;
rot_angle = linspace(0,pi/4,20).';
gmr_array = 10.^(linspace(-.5,2,10).');
gmc = 0;
Phiy  = zeros(length(gmr_array),length(rot_angle));
results = [];f
results.gmr = gmr_array;
results.gmc = gmc;
results.mu = mu_array;
results.rot_angle = rot_angle;
results.Vy = Phiy;
Sxx = Phiy;
results.Sxx = Phiy;
for kk = 1:length(gmr_array)
    for ii = 1:length(mu_array)
        for jj = 1:length(rot_angle)
            iitr = (kk - 1) * length(rot_angle) + jj;
            disp(['finishing percentage:',num2str(iitr/length(rot_angle)...
                /length(gmr_array)*100,3),'%']);
            if jj == 1 && kk==1
                para = a_para_init('FSType',"Geo",'aa',0.40,'gmr',gmr_array(kk),...
                    'gmc',gmc,'Ny',100,'Nth',140,'FSrot_angle',rot_angle(1),'jobdis','gmrTBSimpleTest',...
                    'TS',time,'Mitr',1e3);
            else
                para = a_para_renew(para,'FSrot_angle',rot_angle(jj),'gmr',gmr_array(kk));
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
            else
                Phiy(kk,jj) = trapz(para.y,para.src.Ey);
            end
            results.Vy = Phiy;
            save(strcat(para.Xfile_name2,'/results.mat'),"results","-v7.3");
        end
        rot_angle = rot_angle(end:-1:1);
    end
end

